import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_textfield.dart';
import 'package:modney_flutter_boilerplate/theme/text/app_text_theme.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';

class WrappedTextField extends StatefulWidget {
  WrappedTextField({
    super.key,
    required this.name,
    required this.label,
    this.textStyle,
  });
  String name, label;
  TextStyle? textStyle;

  @override
  _WrappedTextFieldState createState() => _WrappedTextFieldState();
}

class _WrappedTextFieldState extends State<WrappedTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.h,
        margin: EdgeInsets.symmetric(
            horizontal: $constants.insets.md, vertical: $constants.insets.xxs),
        child: CupertinoTextField(
          placeholder: '${widget.label} 입력하세요',
          placeholderStyle:
              widget.textStyle ?? getTextTheme(context).placeholder,
          keyboardType: TextInputType.text,
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border.all(width: 1, color: Color(0xFFA9A9A9)),
            borderRadius: BorderRadius.circular(10.r),
          ),
        )
        // TextField(
        //   style: getTextTheme(context).bodyMedium,
        //   maxLines: 1,
        //   minLines: 1,
        //   textAlignVertical: TextAlignVertical.center,
        //   textAlign: TextAlign.start,
        //   decoration: InputDecoration(
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(8.r),
        //       ),
        //       // alignLabelWithHint: true,
        //       hintStyle: TextStyle(
        //         fontSize: 16.sp,
        //       ),
        //       hintText: '${widget.label} 을/를 입력하세요',
        //       // label: ,
        //       errorText: '',
        //       labelText: widget.label,
        //       labelStyle: getTextTheme(context).titleMedium!.copyWith(
        //             fontSize: 16.sp,
        //           ),
        //       helperText: ''),
        // )

        // CustomTextField(
        //   key: Key(widget.name),
        //   formControlName: widget.name,
        //   keyboardType: TextInputType.text,
        //   textInputAction: TextInputAction.next,
        //   labelText: '${widget.label}',
        //   hintText: '${widget.label} 을/를 입력하세요',
        //   minLength: 4,
        //   isRequired: true,
        // ),
        );
  }
}
