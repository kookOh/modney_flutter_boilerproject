import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';

class LiveConsultItem extends StatefulWidget {
  const LiveConsultItem({Key? key}) : super(key: key);

  @override
  _LiveConsultItemState createState() => _LiveConsultItemState();
}

class _LiveConsultItemState extends State<LiveConsultItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO : QR 코드 데이터 연동
      onTap: () =>
          AutoRouter.of(context).push(FacechatRoute(isCustomer: false)),
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
                    '2024. 01. 12  01:26',
                    style: getTextTheme(context).bodySmall!.copyWith(
                            color: getCustomOnPrimaryColor(
                          context,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all($constants.insets.xs),
              child: ElevatedButton(
                // TODO ; 페이스챗 이동
                onPressed: () => AutoRouter.of(context)
                    .push(FacechatRoute(isCustomer: false)),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    getCustomOnPrimaryColor(context),
                  ),
                  foregroundColor: MaterialStatePropertyAll(
                    Color(0xFFFFFFFF),
                  ),
                ),
                child: Text(
                  '상담 시작',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
