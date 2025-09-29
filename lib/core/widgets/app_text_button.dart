import 'package:flutter/material.dart';

import '../theming/colors_manager.dart';
import '../theming/text_styles.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    this.buttonText,
    this.textStyle,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHeight,
    this.borderColor,
    this.child,
  });
  final String? buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
        ),
        side: WidgetStatePropertyAll<BorderSide>(
          BorderSide(color: borderColor ?? ColorsManager.white, width: 1),
        ),
        backgroundColor: WidgetStatePropertyAll<Color>(
          backgroundColor ?? ColorsManager.turquoise,
        ),
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 12,
            vertical: verticalPadding ?? 14,
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(buttonWidth ?? 0, buttonHeight ?? 55),
        ),
        maximumSize: buttonWidth != null
            ? WidgetStatePropertyAll(Size(buttonWidth!, buttonHeight ?? 55))
            : null,
      ),

      child:
          child ??
          Text(
            buttonText ?? "",
            style:
                textStyle ??
                TextStyles.semiBold15.copyWith(color: ColorsManager.white),
          ),
    );
  }
}
