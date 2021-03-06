import 'package:flutter/material.dart';
import 'package:my_app/core/ui/component_styles/text_style.dart';
import 'package:my_app/core/ui/app_style.dart';

InputDecoration customInputDecoration1(
  String label, {
  Widget? suffixIcon,
  String? errorText,
  String? placeholder,
  Color? borderColor,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
    suffixIcon: suffixIcon,
    errorText: errorText,
    hintText: placeholder,
    errorStyle: customTextStyle(
      FontWeight.w700,
      14,
      VivassimoTheme.redActive,
    ),
    alignLabelWithHint: true,
    labelText: label,
    labelStyle: customTextStyle(
      FontWeight.w700,
      18,
      VivassimoTheme.purpleActive,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: VivassimoTheme.redActive,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: borderColor ?? VivassimoTheme.purpleActive,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: borderColor ?? VivassimoTheme.purpleActive,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: borderColor ?? VivassimoTheme.purpleActive,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}
