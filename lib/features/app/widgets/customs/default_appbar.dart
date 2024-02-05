import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

PreferredSizeWidget DefaultAppbar({
  required BuildContext context,
  required String title,
  void Function()? onPressed,
}) {
  return PreferredSize(
    preferredSize: Size(360.w, 50.h),
    child: AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      // foregroundColor: Color(0xFFFDFDFE),
      title: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: getTextTheme(context).titleLarge!.copyWith(
                color: getCustomOnPrimaryColor(context),
              ),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: IconButton(
          padding: EdgeInsets.only(left: 8.w),
          onPressed: () {
            // Navigator.pop(context);
            onPressed == null ? AutoRouter.of(context).pop() : onPressed.call();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
    ),
  );
}
