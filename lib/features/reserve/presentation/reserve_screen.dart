import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/facechat/presentation/facechat_screen.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

@RoutePage()
class ReserveScreen extends StatefulWidget {
  ReserveScreen({super.key});

  @override
  _ReserveScreenState createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context, title: '가나다 약국 투약기'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '365일 약사 상담 시스템\n원격화상 투약기',
            style: getTextTheme(context).bodyMedium,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 285.w,
            height: 420.h,
            child: Image.asset(
              R.images.image_machine,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            '이용시간: 연중무휴, 매일 밤 10시부터 아침 6시까지',
            style: getTextTheme(context).bodySmall,
          ),
          Text(
            '제품: 응급시 필요한 일반 의약품',
            style: getTextTheme(context).bodySmall,
          ),
          Text(
            '반드시 카드 결제만 가능합니다.',
            style: getTextTheme(context).bodySmall,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: $constants.insets.lg),
              width: double.maxFinite,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 42.h,
                  child: PrimaryButton(
                    text: '일반의약품 상담받기',
                    onPressed: () {
                      AutoRouter.of(context).push(FacechatRoute());
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
