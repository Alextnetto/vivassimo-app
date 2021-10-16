import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton1 extends StatelessWidget {
  final String label;
  final Color primary, onPrimary, borderColor;
  final Function onPressed;
  const CustomButton1({
    Key? key,
    required this.label,
    required this.primary,
    required this.onPrimary,
    required this.borderColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: onPrimary,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        side: BorderSide(
          width: 2.0,
          color: borderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}