import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/facechat/presentation/widgets/certification.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

@RoutePage()
class FacechatScreen extends StatefulWidget {
  FacechatScreen({super.key, this.isCustomer = true});
  bool isCustomer;

  @override
  _FacechatScreenState createState() => _FacechatScreenState();
}

class _FacechatScreenState extends State<FacechatScreen> {
  // Signaling? _signaling;
  List<dynamic> _peers = [];
  String? _selfId;

  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _inCalling = false;
  // Session? _session;
  DesktopCapturerSource? selected_source_;
  bool _waitAccept = false;

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    super.initState();
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
                child: RTCVideoView(_remoteRenderer),
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
                child: RTCVideoView(_localRenderer),
              ),
            ),
            Positioned(
              right: 40.w,
              top: 10.h,
              child: GestureDetector(
                onTap: () {
                  // show certification
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return const Certification();
                    },
                  );
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
