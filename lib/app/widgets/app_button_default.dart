import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import 'is_mobile.dart';
import 'text_default.dart';

class AppButtonDefault extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isLoading;
  final bool usingJustPadding;
  final double paddingVertical;
  final double? radius;
  final double width;
  final double? height;
  final bool? isValid;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final VisualDensity? visualDensity;
  final TextAlign? textAlign;
  final BorderSide? side;
  final bool hasIconNext;
  final IconData? icon;
  final IconData? iconNext;
  final bool hasIcon;
  final TextOverflow? textOverflow;

  const AppButtonDefault({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.usingJustPadding = false,
    this.width = 250,
    this.height,
    this.paddingVertical = 3,
    this.radius,
    this.isValid,
    this.buttonColor = AppColors.primary,
    this.textColor,
    this.fontSize,
    this.visualDensity,
    this.textAlign,
    this.hasIconNext = false,
    this.icon,
    this.hasIcon = false,
    this.iconNext,
    this.side,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    bool isValidButton = isValid ?? false;

    return SizedBox(
      width: usingJustPadding ? null : width,
      height: usingJustPadding ? null : height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: visualDensity ?? VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12),
          ),
          backgroundColor: isValidButton ? buttonColor : AppColors.primary,
          disabledBackgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: usingJustPadding ? 20 : 0,
            vertical: paddingVertical,
          ),
          side: side,
        ),
        onPressed: isLoading || !isValidButton ? null : onTap,
        child: Row(
          mainAxisAlignment:
              textAlign == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
          children: [
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 3.5,
                    backgroundColor: AppColors.backgroundLight.withValues(
                      alpha: 0.5,
                    ),
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.backgroundLight,
                    ),
                  ),
                ),
              ),
            if (!isLoading)
              Row(
                children: [
                  if (hasIcon) Icon(icon, color: AppColors.backgroundLight),
                  SizedBox(width: hasIcon ? 10 : 0),
                  TextDefault(
                    text: text,
                    fontSize:
                        isMobile(Get.context!)
                            ? fontSize ?? 14
                            : fontSize ?? 18,
                    color: textColor ?? AppColors.backgroundLight,
                    textAlign: textAlign ?? TextAlign.center,
                    overflow: textOverflow,
                  ),
                  SizedBox(width: hasIconNext ? 10 : 0),
                  if (hasIconNext)
                    CircleAvatar(
                      backgroundColor: AppColors.backgroundLight,
                      child: Icon(
                        iconNext ?? Icons.arrow_forward_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
