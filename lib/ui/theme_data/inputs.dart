import 'package:flutter/material.dart';

abstract class InputsThemeData {
  static const double radius = 10.0;
  static const Color grey700 = Color.fromRGBO(51, 65, 85, 1.0);

  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(226, 232, 240, 1.0),
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(radius),
  );

  static OutlineInputBorder inputBorderSelected = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.blue,
    ),
    borderRadius: BorderRadius.circular(radius),
  );

  static OutlineInputBorder inputForm = OutlineInputBorder(
    borderSide: BorderSide(
      color: grey700.withOpacity(0.2),
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(0.0),
  );

  static OutlineInputBorder inputFormSelected = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(0.0),
  );
}
