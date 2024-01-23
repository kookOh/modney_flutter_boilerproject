import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_text_theme.freezed.dart';

typedef MaterialTextTheme = TextTheme;

@freezed
class AppTextTheme with _$AppTextTheme {
  factory AppTextTheme({
    required TextStyle displayLarge,
    required TextStyle displayMedium,
    required TextStyle displaySmall,
    required TextStyle headlineLarge,
    required TextStyle headlineMedium,
    required TextStyle headlineSmall,
    required TextStyle titleLarge,
    required TextStyle titleMedium,
    required TextStyle titleSmall,
    required TextStyle bodyLarge,
    required TextStyle bodyMedium,
    required TextStyle bodySmall,
    required TextStyle labelLarge,
    required TextStyle labelMedium,
    required TextStyle labelSmall,
  }) = _AppTextTheme;

  const AppTextTheme._();

  MaterialTextTheme get materialTextTheme => MaterialTextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}

extension customTextTheme on MaterialTextTheme {
  TextStyle get body3bold => TextStyle(
        color: Color(0xFF212121),
        fontSize: 14.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.60,
      );
  TextStyle get body3regular => TextStyle(
        color: Color(0xFF212121),
        fontSize: 14.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.60,
      );
  TextStyle get body2bold => TextStyle(
        color: Color(0xFF212121),
        fontSize: 16.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.60,
      );
  TextStyle get body2regular => TextStyle(
        color: Color(0xFF212121),
        fontSize: 16.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.60,
      );

  TextStyle get caption1Regular => TextStyle(
        color: Color(0xFF212121),
        fontSize: 12.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.60,
      );
  TextStyle get caption2Regular => TextStyle(
        color: Color(0xFF212121),
        fontSize: 11.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.60,
      );
  TextStyle get caption2Bold => TextStyle(
        color: Color(0xFF212121),
        fontSize: 11.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.60,
      );
  TextStyle get caption1Bold => TextStyle(
        color: Color(0xFF212121),
        fontSize: 12.sp,
        fontFamily: 'Spoqa Han Sans Neo',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.60,
      );
  TextStyle get greyText => TextStyle(
        color: Color(0xFF999999),
      );
}
