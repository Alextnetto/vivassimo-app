import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/style.dart';

InputDecoration customInputDecoration1(
  String label, {
  IconButton? suffixIcon,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
    suffixIcon: suffixIcon,
    errorStyle: GoogleFonts.manrope(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: VivassimoTheme.redActive,
      ),
    ),
    hintText: label,
    hintStyle: GoogleFonts.manrope(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: VivassimoTheme.purpleActive,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: VivassimoTheme.purpleActive,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: VivassimoTheme.purpleActive,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: VivassimoTheme.purpleActive,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}