import 'dart:ui';

import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

  static final headerTextStyle = baseTextStyle.copyWith(
    color: const Color(0xff343a40),
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  static final headerWhiteTextStyle = headerTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0
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

  static final regularTextStyleButMono =regularTextStyle.copyWith(
    fontFeatures: [FontFeature.tabularFigures()]
  );

  static final italicTextStyle = regularTextStyle.copyWith(
    fontStyle: FontStyle.italic
  );

  static final subHeaderTextStyle = headerTextStyle.copyWith(
    fontSize: 16.0,
      fontWeight: FontWeight.w300,
  );
}
