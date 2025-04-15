import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TextDefault extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;
  final TextDecoration? decoration;
  final String? fontFamily;
  final double? height;
  final int? maxLines;
  final bool? softWrap;
  final double? letterSpacing;

  const TextDefault({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.shadows,
    this.decoration,
    this.fontFamily,
    this.height,
    this.maxLines,
    this.softWrap,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: height ?? 1.2,
        shadows: shadows,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.text,
        fontWeight: fontWeight ?? FontWeight.w400,
        decoration: decoration,
        decorationColor: color,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily ?? 'Poppins',
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
