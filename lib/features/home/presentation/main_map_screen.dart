import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/aliases.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

@RoutePage()
class MainMapScreen extends StatefulWidget {
  const MainMapScreen({Key? key}) : super(key: key);

  @override
  _MainMapScreenState createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  late KakaoMapController mapController;
  Set<Marker> markers = {};
  List<CustomOverlay> customOverlays = List.empty(growable: true);
  int idCnt = 0;
  @override
  void initState() {
    // TODO: implement initState
    final customOverlay = CustomOverlay(
      customOverlayId: 'overlay${idCnt++}',
      latLng: LatLng(37.360861564933884, 126.93064057943964),
      content:
          // '<p style="background-color: red; padding: 8px; border-radius: 8px;">카카오!</p>',
          '''<div style="width: 109px; height: 18px; padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; background: #001AFF; border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex">  <div style="color: white; font-size: 12px; font-family: Pretendard; font-weight: 500; word-wrap: break-word">가나다 약국 투약기</div></div>''',
      // xAnchor: 1,
      yAnchor: 3,
      zIndex: 5,
    );

    customOverlays.add(customOverlay);

    // final customOverlay2 = CustomOverlay(
    //   customOverlayId: UniqueKey().toString(),
    //   latLng: LatLng(37.359230374060395, 126.93007769038823),
    //   content:
    //       '<p style="background-color: blue; padding: 8px; border-radius: 8px;">카카오2!</p>',
    //   // xAnchor: 1,
    //   yAnchor: 1.8,
    //   zIndex: 5,
    // );

    // customOverlays.add(customOverlay2);
    setState(() {});
    super.initState();
  }

  Future<void> makeOverlay(LatLng latlng, String name) async {
    final customOverlay = CustomOverlay(
      // customOverlayId: UniqueKey().toString(),
      customOverlayId: 'customOverlay+${idCnt++}',
      latLng: latlng,
      content:
          // '<p style="background-color: red; padding: 8px; border-radius: 8px;">카카오!</p>',
          '''
          <div style="width: 109px; height: 18px; padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; background: #001AFF; border-radius: 10px; overflow: hidden; justify-content: center; align-items: center; gap: 10px; display: inline-flex">
            <div style="color: white; font-size: 12px; font-family: Pretendard; font-weight: 500; word-wrap: break-word">
            $name
            </div>
          </div>''',
      // xAnchor: 1,
      yAnchor: 1.8,
      zIndex: 3,
      isClickable: true,
      xAnchor: 0.5,
    );
    final marker = Marker(
        markerId: UniqueKey().toString(),
        latLng: latlng,
        width: 35,
        height: 35,
        offsetX: 15,
        offsetY: 44,
        // infoWindowContent: '가나다약국',
        // infoWindowFirstShow: true,
        // infoWindowRemovable: false,
        markerImageSrc:
            // 'https://w7.pngwing.com/pngs/96/889/png-transparent-marker-map-interesting-places-the-location-on-the-map-the-location-of-the-thumbnail.png',
            'https://www.iconsdb.com/icons/preview/blue/map-marker-2-xxl.png');

    markers.add(marker);
    customOverlays.add(customOverlay);
    setState(() {});
    logIt.debug(
        'overlays len=${customOverlays.length} , id=${customOverlay.customOverlayId}  latlng=$latlng');
    // await mapController.addCustomOverlay(customOverlays: customOverlays);
    // mapController.relayout();
    return Future.delayed(Duration(microseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {},
                child: const PrimaryButton(
                  text: '내 주변 화상투약기 찾기',
                  width: 180,
                  height: 40,
                )),
            GestureDetector(
              onTap: () => AutoRouter.of(context).push(MypageRoute()),
              child: ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  R.images.icon_mypage,
                  fit: BoxFit.fill,
                  width: 80,
                ),
              ),
            ),
          ],
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        KakaoMap(
          onMapCreated: (controller) async {
            LatLng latlng = await controller.getCenter();
            await makeOverlay(latlng, '가나다 약국 투약기');
            mapController = controller;

            logIt.debug('map created $latlng');
            // mapController.relayout();
            setState(() {});
          },
          onCenterChangeCallback: (latlng, zoomLevel) async {
            // logIt.debug('center Changed $latlng');
            // await makeOverlay(latlng, '가나다 약국 투약기');
          },
          onMarkerTap: (markerId, latLng, zoomLevel) async {
            logIt.debug('markerId=$markerId , latlng=$latLng');
            AutoRouter.of(context).push(ReserveRoute());
          },
          onCustomOverlayTap: (customOverlayId, latLng) {
            logIt.debug(
                'onCustomOverlayTap id=$customOverlayId, latlng=$latLng');
            logIt.debug('customOverlay len=${customOverlays.length}');
            AutoRouter.of(context).push(ReserveRoute());
          },
          center: LatLng(37.3608681, 126.9306506),
          markers: markers.toList(),
          customOverlays: customOverlays,
        ),
        // Positioned(
        //   bottom: 50,
        //   left: 10,
        //   child: Container(
        //     width: 300,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       shape: BoxShape.rectangle,
        //       border: Border.all(width: 10, color: const Color(0xFFA9A9A9)),
        //       borderRadius: BorderRadius.circular(10.r),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
