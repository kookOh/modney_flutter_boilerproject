import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

@RoutePage()
class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '가나다 약국'),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO : Network_cached_image
            // TODO : 실제 QR코드 연동.
            // ! Temp 임시 큐알코드.
            Image.network(
              'http://static.ebs.co.kr/images/public/2016/02/15/13/53/54/70e3755c-162d-4f58-b521-8305ca5e3f8d.jpg',
              width: 270.w,
              height: 210.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints(
                minWidth: 50.w,
                maxWidth: 200.w,
                minHeight: 30.h,
                maxHeight: 90.h,
              ),
              height: 30.h,
              decoration: BoxDecoration(
                color: getCustomOnPrimaryColor(context),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '가나다 약국 투약기',
                style: getTextTheme(context).bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            // appBar 높이만큼 전체 Column  children 위치 조정.
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
