import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/constants.dart';
import 'package:flutter_theme_selector/src/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals_flutter.dart';

import 'settings_store.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.

class SettingsSignalsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  final SharedPreferencesWithCache prefs;
  SettingsSignalsService(this.prefs);

  late final store = SharedPreferencesStore(prefs);

  // second value is default
  late final themeMode = SettingsSignal(
    'system',
    THEME_MODE,
    store,
  );
  late final seed = SettingsSignal(
    DEFAULT_COLOR,
    COLOR_SEED,
    store,
  );
  late final fontScale = SettingsSignal(
    "1.0",
    FONT_SIZE_FACTOR,
    store,
  );
  late final contrast = SettingsSignal(
    DEFAULT_CONTRAST,
    CONTRAST_VALUE,
    store,
  );
  late final displayHeadlineFont = SettingsSignal(
    "Noto Sans",
    DISPLAY_FONT,
    store,
  );
  late final bodyLabelFont = SettingsSignal(
    "Noto Sans",
    BODY_FONT,
    store,
  );
  late final variant = SettingsSignal(
    "tonalSpot",
    VARIANT,
    store,
  );
  // Signal<ColorSeed> get colorSeed {
  //
  //   Color? secondarySeed = (await prefs.getInt(COLOR_SECONDARY_SEED)).toColor();
  //   Color? tertiarySeed = (await prefs.getInt(COLOR_TERTIARY_SEED)).toColor();
  //   Color? neutralSeed = (await prefs.getInt(COLOR_NEUTRAL_SEED)).toColor();
  //   Color? neutralVariantSeed = (await prefs.getInt(COLOR_NV_SEED)).toColor();
  //   Color? errorSeed = (await prefs.getInt(COLOR_ERROR_SEED)).toColor();
  // }

  void dispose() {}

  bool monochrome() {
    bool? isMonochrome = prefs.getBool(MONOCHROME);
    if (isMonochrome == null) {
      return false;
    } else {
      return isMonochrome;
    }
  }

  final theme = signal<ThemeData>(ThemeData.light());

  late final textTheme = computed(() {
    TextTheme baseTextTheme = theme.value.textTheme;
    TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
      bodyLabelFont.value,
      baseTextTheme,
    );
    TextTheme displayTextTheme = GoogleFonts.getTextTheme(
      displayHeadlineFont.value,
      baseTextTheme,
    );
    return displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
  });

  late final schemeVariant = computed(() {
    return DynamicSchemeVariant.values.firstWhere(
      (elem) => elem.name == variant.value,
      orElse: () => DynamicSchemeVariant.tonalSpot,
    );
  });

  late final seedColor = computed(() {
    return int.parse(seed.value).toColor()!;
  });

  late final lightColorScheme = computed(() {
    return ColorScheme.fromSeed(
      seedColor: seedColor.value,
      brightness: Brightness.light,
      dynamicSchemeVariant: schemeVariant.value,
    );
  });

  late final darkColorScheme = computed(() {
    return ColorScheme.fromSeed(
      seedColor: seedColor.value,
      brightness: Brightness.dark,
      dynamicSchemeVariant: schemeVariant.value,
    );
  });

  late final lightTheme = computed(() {
    return ThemeData(
      textTheme: textTheme.value.apply(
        bodyColor: lightColorScheme.value.onSurface,
        displayColor: lightColorScheme.value.onSurface,
      ),
      colorScheme: lightColorScheme.value,
    );
  });

  late final darkTheme = computed(() {
    return ThemeData(
      textTheme: textTheme.value.apply(
        bodyColor: darkColorScheme.value.onSurface,
        displayColor: darkColorScheme.value.onSurface,
      ),
      colorScheme: darkColorScheme.value,
    );
  });
}

extension Converters on String {
  ThemeMode toThemeMode() {
    switch (this) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
    }
    return ThemeMode.system;
  }
}
