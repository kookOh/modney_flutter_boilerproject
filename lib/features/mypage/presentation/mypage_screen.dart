import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

@RoutePage()
class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  _MypageScreenState createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '마이페이지'),
      body: Padding(
        padding: EdgeInsets.all($constants.insets.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.pushRoute(MyInfoRoute()),
              child: SizedBox(
                width: double.maxFinite,
                height: 40.h,
                child: Text(
                  '내 정보',
                  style: getTextTheme(context).titleMedium!,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => AutoRouter.of(context).push(MyConsultListRoute()),
              child: SizedBox(
                width: double.maxFinite,
                height: 40.h,
                child: Text(
                  '상담 내역 확인 QR코드',
                  style: getTextTheme(context).titleMedium!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
