// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

String DISPLAY_FONT = "displayFont";
String BODY_FONT = "bodyFont";
String FONT_SIZE_FACTOR = "fontSizeFactor";
double MAX_FONT_SIZE_FACTOR = 2.5;
String COLOR_SEED = "colorSeed";
String COLOR_SECONDARY_SEED = "colorSecondarySeed";
String COLOR_TERTIARY_SEED = "colorTertiarySeed";
String COLOR_NEUTRAL_SEED = "colorNeutralSeed";
String COLOR_NV_SEED = "colorNeutralVariantSeed";
String COLOR_ERROR_SEED = "colorErrorSeed";
String MONOCHROME = "isMonochrome";
String VARIANT = "variant";
String THEME_MODE = "themeMode";
String CONTRAST_VALUE = "contrast";

class ColorSeed extends SimpleColorSeed {
  Color? _secondarySeed = null, _tertiarySeed =null, _errorSeed, _neutralSeed, _neutralVariantSeed;

  ColorSeed(super._label, super._seed);

}

class SimpleColorSeed {
  final String _label;
  final Color _seed;

  String get label => _label;

  const SimpleColorSeed(this._label, this._seed);

  Color get seed => _seed;
}

// enum ColorSeed {
//   baseColor('M3 Baseline', Color(0xff6750a4)),
//   indigo('Indigo', Colors.indigo),
//   blue('Blue', Colors.blue),
//   teal('Teal', Colors.teal),
//   green('Green', Colors.green),
//   yellow('Yellow', Colors.yellow),
//   orange('Orange', Colors.orange),
//   deepOrange('Deep Orange', Colors.deepOrange),
//   pink('Pink', Colors.pink);
//
//   const ColorSeed(this.label, this.color);
//   final String label;
//   final Color color;
// }