import 'package:flutter/material.dart';

class FleetStyles {
  static const double cardRadius = 12;
  static const EdgeInsets cardPadding = EdgeInsets.all(16);

  static BoxDecoration cardDeco = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(cardRadius),
    border: Border.all(color: const Color(0xffe6e6e6), width: 2),
  );
}
