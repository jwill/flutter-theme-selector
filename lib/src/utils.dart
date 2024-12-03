import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';

FlutterSignal<TextTheme> createTextTheme(
  BuildContext context,
  Signal<String> bodyFontString,
  Signal<String> displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString.value, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString.value, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );

  return signal(textTheme);
}

FlutterSignal<ColorScheme> colorScheme(
  Brightness brightness,
  Signal<String> seed,
  Signal<String> variant,
) {
  return signal(
    ColorScheme.fromSeed(
      seedColor: int.parse(seed.value).toColor()!,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.values.firstWhere(
          (elem) => elem.name == variant.value,
          orElse: () => DynamicSchemeVariant.tonalSpot),
    ),
  );
}

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
