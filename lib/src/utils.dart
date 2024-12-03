import 'package:flutter/material.dart';

extension ColorUtils on Color {
  String toHex() {
    final rr = (r * 255.0).round().toRadixString(16).padLeft(2, '0');
    final gg = (g * 255.0).round().toRadixString(16).padLeft(2, '0');
    final bb = (b * 255.0).round().toRadixString(16).padLeft(2, '0');
    return '#$rr$gg$bb';
  }

  Color onColor() {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

extension ColorIntUtils on int? {
  Color? toColor() {
    if (this == null) {
      return null;
    } else {
      return Color(this!.toInt());
    }
  }
}

extension WidgetUtils on Widget {
  Widget opacity(double value) {
    return Opacity(
      opacity: value,
      child: this,
    );
  }

  Widget padding(EdgeInsetsGeometry value) {
    return Padding(
      padding: value,
      child: this,
    );
  }
}

Brightness getBrightnessForThemeMode(ThemeMode mode) {
  return mode == ThemeMode.light ? Brightness.light : Brightness.dark;
}
