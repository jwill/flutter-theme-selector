// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

String DISPLAY_FONT = "displayFont";
String BODY_FONT = "bodyFont";

class ColorSeed extends SimpleColorSeed {
  final Color? _secondarySeed, _tertiarySeed, _errorSeed, _neutralSeed, _neutralVariantSeed;

  ColorSeed(super.label, super.seed, this._secondarySeed, this._tertiarySeed, this._errorSeed, this._neutralSeed, this._neutralVariantSeed);

}

class SimpleColorSeed {
  final String _label;
  final Color _seed;

  const SimpleColorSeed(this._label, this._seed);
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