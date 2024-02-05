import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/theme/text/app_text_theme.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

abstract class CustomAlertModal {
  const CustomAlertModal._();
  static void showAlert(
    BuildContext context, {
    required String text,
    void Function()? onPressed,
    void Function()? onCancelPressed,
    double fontSize = 20,
    double height = 260,
    double width = 300,
  }) {
    showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            content: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSize,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none),
                  )
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            actions: [
              if (onCancelPressed != null)
                PrimaryButton(
                  onPressed: () {
                    AutoRouter.of(_).pop();
                    onCancelPressed.call();
                  },
                  text: '취소',
                  width: 120,
                  height: 40,
                  primary: false,
                ),
              PrimaryButton(
                onPressed: () {
                  AutoRouter.of(_).pop();
                  onPressed?.call();
                },
                text: '확인',
                width: 120,
                height: 40,
              ),
            ],
          );
        });
  }
}
