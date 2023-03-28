import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BusinetButton extends StatelessWidget {
  const BusinetButton({
    super.key,
    this.shape,
    this.onPressed,
    this.child,
    this.height,
    this.radius,
    this.minWidth,
    this.fontSize,
    this.color,
    this.text,
    this.elevation,
    this.textColor,
    this.disabledColor,
    this.padding,
    this.focusNode,
  });

  final ShapeBorder? shape;
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final double? height;
  final double? radius;
  final double? minWidth;
  final double? fontSize;
  final Color? color;
  final double? elevation;
  final Color? textColor;
  final Color? disabledColor;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 24),
          ),
      onPressed: onPressed,
      height: height ?? 45,
      minWidth: minWidth,
      color: color,
      //  ?? Colors.white
      // elevation: elevation ?? 0,
      textColor: textColor,
      padding: padding ?? const EdgeInsets.fromLTRB(20, 4, 20, 4),
      focusNode: focusNode,
      disabledColor: disabledColor ?? Theme.of(context).hoverColor,
      child: child ??
          Text(
            text.toString().tr,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
