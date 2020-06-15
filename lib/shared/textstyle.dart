import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

  static final headerTextStyle = baseTextStyle.copyWith(
    color: const Color(0xff343a40),
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  static final headerPageTextStyle = baseTextStyle.copyWith(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.w500);

  static final commonTextStyle = baseTextStyle.copyWith(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w400
  );

  static final commonTextStyleGreyColor = commonTextStyle.copyWith(
      color: const Color(0xff6c757d)
  );

  static final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xff6c757d),
      fontSize: 12.0,
      fontWeight: FontWeight.w400);

  static final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
}
