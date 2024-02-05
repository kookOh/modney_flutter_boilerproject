import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.text,
    this.primary = true,
    this.onPressed,
    this.width = 300,
    this.height = 50,
    this.radius = 20,
    super.key,
  });

  final void Function()? onPressed;
  final double height;
  final String text;
  final double width;
  final bool primary;
  final double radius;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed?.call();
      },
      child: Container(
        alignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        decoration: ShapeDecoration(
          color:
              widget.primary ? getCustomOnPrimaryColor(context) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: getCustomOnPrimaryColor(context),
            ),
            borderRadius: BorderRadius.circular(widget.radius.r),
          ),
        ),
        child: AutoSizeText(
          widget.text,
          // textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.primary
                ? Colors.white
                : getCustomOnPrimaryColor(context),
          ),
        ),
      ),
    );
  }
}
