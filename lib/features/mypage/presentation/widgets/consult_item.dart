import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

class ConsultItem extends StatefulWidget {
  const ConsultItem({Key? key}) : super(key: key);

  @override
  _ConsultItemState createState() => _ConsultItemState();
}

class _ConsultItemState extends State<ConsultItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO : QR 코드 데이터 연동
      onTap: () => AutoRouter.of(context).push(QrRoute()),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.2.h,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: $constants.insets.md,
                vertical: $constants.insets.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '가나다 약국',
                    style: getTextTheme(context).titleLarge!,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'QR코드를 확인하세요',
                    style: getTextTheme(context).bodySmall!,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all($constants.insets.md),
              child: Text(
                '2024.01.12',
                style: getTextTheme(context).bodySmall!.copyWith(
                      color: getCustomOnPrimaryColor(context),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
