import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';

class Certification extends StatefulWidget {
  const Certification({Key? key}) : super(key: key);

  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width - 80.w,
        padding: EdgeInsets.all($constants.insets.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.popRoute();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.cancel_outlined,
                  size: 25.r,
                ),
              ),
            ),
            Text(
              '가나다 약국 약사님의\n약사 면허증',
              style: getTextTheme(context).titleMedium!.copyWith(
                    color: getCustomOnPrimaryColor(context),
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Image.asset(R.images.image_machine))
          ],
        ),
      ),
    );
  }
}
