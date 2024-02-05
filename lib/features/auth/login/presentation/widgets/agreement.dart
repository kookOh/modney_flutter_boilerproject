import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/theme/text/app_text_theme.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

class Agreement extends StatefulWidget {
  const Agreement({Key? key}) : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  bool isChecked = false;

  void onTap() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
              margin: EdgeInsets.symmetric(
                  horizontal: $constants.insets.md,
                  vertical: $constants.insets.xxs),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(width: 1, color: Color(0xFFA9A9A9)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '다음 약관을 확인하였습니다',
                    style: getTextTheme(context).placeholder,
                  ),
                  isChecked ? Icon(Icons.check) : SizedBox.shrink()
                ],
              )),
        ),
        Container(
          height: 112.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
          margin: EdgeInsets.symmetric(
              horizontal: $constants.insets.md,
              vertical: $constants.insets.xxs),
          color: const Color(0xFFF4F4F4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '마케티 광고 수신 동의',
                style: getTextTheme(context).placeholder,
              ),
              Text(
                '개인정보이용 동의',
                style: getTextTheme(context).placeholder,
              ),
            ],
          ),
        )
      ],
    );
  }
}
