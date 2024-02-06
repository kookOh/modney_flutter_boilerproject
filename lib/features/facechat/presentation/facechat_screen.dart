import 'dart:convert';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/io_client.dart';
import 'package:modney_flutter_boilerplate/features/app/app.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/facechat/module/signalling_service.dart';
import 'package:modney_flutter_boilerplate/features/facechat/presentation/widgets/certification.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/aliases.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:universal_platform/universal_platform.dart';

@RoutePage()
class FacechatScreen extends StatefulWidget {
  FacechatScreen({super.key, this.isCustomer = true});
  bool isCustomer;

  @override
  _FacechatScreenState createState() => _FacechatScreenState();
}

class _FacechatScreenState extends State<FacechatScreen> {
  // Signaling? _signaling;
  // socket instance
  final socket = SignallingService.instance.socket;
  // videoRenderer for localPeer
  final _localRTCVideoRenderer = RTCVideoRenderer();
  // videoRenderer for remotePeer
  final _remoteRTCVideoRenderer = RTCVideoRenderer();
  // mediaStream for localPeer
  MediaStream? _localStream;
  // RTC peer connection
  RTCPeerConnection? _rtcPeerConnection;
  // list of rtcCandidates to be sent over signalling
  List<RTCIceCandidate> rtcIceCadidates = [];
  // media status
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  dynamic incomingSDPOffer, offer;

  @override
  void initState() {
    // initializing renderers

    SignallingService.instance.socket!.on("newCall", (data) {
      if (mounted) {
        // set SDP Offer of incoming call
        setState(() {
          incomingSDPOffer = data;
          offer = incomingSDPOffer['sdpOffer'];
          // calleeId = incomingSDPOffer['callerId'];
        });
        logIt.debug('selfId ${App.selfCallerID}');
        logIt.debug('offer $offer');
      }
    });
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRenderer.initialize();
    // setup Peer Connection
    _setupPeerConnection();

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _setupPeerConnection() async {
    // create peer connection
    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });
    // listen for remotePeer mediaTrack event
    _rtcPeerConnection!.onTrack = (event) {
      _remoteRTCVideoRenderer.srcObject = event.streams[0];
      setState(() {});
    };
    // get localStream
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });
    // add mediaTrack to peerConnection
    _localStream!.getTracks().forEach((track) {
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });
    // set source for local video renderer
    _localRTCVideoRenderer.srcObject = _localStream;
    setState(() {});
    // for Incoming call
    if (offer != null) {
      // listen for Remote IceCandidate
      socket!.on("IceCandidate", (data) {
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["id"];
        int sdpMLineIndex = data["iceCandidate"]["label"];
        // add iceCandidate
        _rtcPeerConnection!.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      });
      // set SDP offer as remoteDescription for peerConnection
      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(offer["sdp"], offer["type"]),
      );
      // create SDP answer
      RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();
      // set SDP answer as localDescription for peerConnection
      _rtcPeerConnection!.setLocalDescription(answer);
      // send SDP answer to remote peer over signalling
      socket!.emit("answerCall", {
        "callerId":
            UniversalPlatform.isAndroid ? App.selfCalleeID : App.selfCallerID,
        "sdpAnswer": answer.toMap(),
      });
    }
    // for Outgoing Call
    else {
      // listen for local iceCandidate and add it to the list of IceCandidate
      _rtcPeerConnection!.onIceCandidate =
          (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);
      // when call is accepted by remote peer
      socket!.on("callAnswered", (data) async {
        // set SDP answer as remoteDescription for peerConnection
        await _rtcPeerConnection!.setRemoteDescription(
          RTCSessionDescription(
            data["sdpAnswer"]["sdp"],
            data["sdpAnswer"]["type"],
          ),
        );
        // send iceCandidate generated to remote peer over signalling
        for (RTCIceCandidate candidate in rtcIceCadidates) {
          socket!.emit("IceCandidate", {
            "calleeId": UniversalPlatform.isAndroid
                ? App.selfCallerID
                : App.selfCalleeID,
            "iceCandidate": {
              "id": candidate.sdpMid,
              "label": candidate.sdpMLineIndex,
              "candidate": candidate.candidate
            }
          });
        }
      });
      // create SDP Offer
      RTCSessionDescription offer = await _rtcPeerConnection!.createOffer();
      // set SDP offer as localDescription for peerConnection
      await _rtcPeerConnection!.setLocalDescription(offer);
      // make a call to remote peer over signalling
      socket!.emit('makeCall', {
        "calleeId":
            UniversalPlatform.isAndroid ? App.selfCallerID : App.selfCalleeID,
        "sdpOffer": offer.toMap(),
      });
    }
  }

  _leaveCall() {
    Navigator.pop(context);
  }

  _toggleMic() {
    // change status
    isAudioOn = !isAudioOn;
    // enable or disable audio track
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    setState(() {});
  }

  _toggleCamera() {
    // change status
    isVideoOn = !isVideoOn;
    // enable or disable video track
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    setState(() {});
  }

  _switchCamera() {
    // change status
    isFrontCameraSelected = !isFrontCameraSelected;
    // switch camera
    _localStream?.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
    });
    setState(() {});
  }

  @override
  void dispose() {
    _localRTCVideoRenderer.dispose();
    _remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppbar(context: context, title: '가나다 약국 투약기'),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 310.w,
                height: 545.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  border: Border.all(
                    width: 1,
                    color: getPrimaryColor(context),
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: RTCVideoView(
                  _remoteRTCVideoRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            ),
            Positioned(
              bottom: 100.h,
              right: 30.w,
              child: Container(
                width: 110.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  border: Border.all(
                    width: 1,
                    color: getPrimaryColor(context),
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: RTCVideoView(
                  _localRTCVideoRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            ),
            Positioned(
              right: 40.w,
              top: 10.h,
              child: GestureDetector(
                onTap: () {
                  // show certification
                  // showDialog<void>(
                  //   context: context,
                  //   builder: (context) {
                  //     return const Certification();
                  //   },
                  // );
                  _setupPeerConnection();
                },
                child: Container(
                  padding: EdgeInsets.all($constants.insets.xxs),
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: getCustomOnPrimaryColor(context),
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AutoSizeText(
                    '약사 면허증 확인',
                    style: getTextTheme(context).bodySmall!.copyWith(
                          color: getCustomOnPrimaryColor(context),
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100.h,
              left: 30.w,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.videocam_rounded),
                    iconSize: 45.r,
                    onPressed: () {
                      //TODO : 영상 On/Off
                    },
                  ),
                  // TODO ! Eleavated Button 제거하기 (테스트))

                  IconButton(
                    onPressed: () {
                      // TODO : 음성 On/OFF
                    },
                    icon: const Icon(Icons.mic),
                    iconSize: 45.r,
                  ),
                  // TODO ! Eleavated Button 제거하기  (테스트)
                  if (!widget.isCustomer)
                    ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context).push(PaymentRequestRoute());
                      },
                      child: Text(
                        '약국처방(TEST)',
                        style: getTextTheme(context).labelSmall!,
                      ),
                    ),
                  if (widget.isCustomer)
                    ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context).push(CustomerPaymentRoute());
                      },
                      child: Text(
                        '결제(TEST)',
                        style: getTextTheme(context).labelSmall!,
                      ),
                    ),
                ],
              ),
            ),
            // 약국 화상채팅
            if (!widget.isCustomer)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 40.h,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButton(
                        text: '약 처방',
                        width: 150.w,
                        height: 42.h,
                        radius: 10,
                        onPressed: () {
                          // 약 처방 페이지 이동
                          AutoRouter.of(context).push(PaymentRequestRoute());
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 40.h,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButton(
                        text: '상담 종료',
                        width: 150.w,
                        height: 42.h,
                        radius: 10,
                        primary: false,
                        onPressed: () {
                          // TODO : 상담취소 후 화상채팅 종료 API CALL
                          CustomAlertModal.showAlert(
                            context,
                            width: 80,
                            height: 140,
                            fontSize: 16,
                            text: '상담이 종료되었습니다.\n\n감사합니다.',
                            onPressed: () => context.popRoute(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

            // 고객 화상채팅
            if (widget.isCustomer)
              Container(
                margin: EdgeInsets.only(
                  bottom: 40.h,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryButton(
                    text: '상담 취소',
                    height: 42.h,
                    onPressed: () {
                      // TODO : 상담취소 후 화상채팅 종료 API CALL
                      CustomAlertModal.showAlert(
                        context,
                        width: 80,
                        height: 140,
                        fontSize: 16,
                        text: '상담이 종료되었습니다.\n\n감사합니다.',
                        onPressed: () => context.popRoute(),
                      );
                    },
                  ),
                ),
              )
          ],
        ));
  }
}
