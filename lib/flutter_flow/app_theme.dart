import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static const Color primaryColor = Color(0xFFFAA307);
  static const Color secondaryColor = Color(0xFF9D0208);
  static const Color tertiaryColor = Color(0xFFFFFFFF);

  static TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );

  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF424242),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static UnderlineInputBorder get kUnderlineInputBorder => UnderlineInputBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      );
}
