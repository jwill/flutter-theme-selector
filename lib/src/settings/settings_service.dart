import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.

class SettingsSignalsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  final SharedPreferencesWithCache prefs;

  EffectCleanup? _cleanup;
  SettingsSignalsService(this.prefs) {
    _cleanup = effect(() {
      for (final entry in setting.store.entries) {
        final value = entry.value.peek();
        if (prefs.getString(entry.key.$1) != value) {
          prefs.setString(entry.key.$1, value).ignore();
        }
      }
    });
  }

  late final setting = signalContainer<String, (String, String)>(
        (val) => signal(prefs.getString(val.$1) ?? val.$2),
    cache: true,
  );

  // second value is default
  Signal<String> get themeMode => setting((THEME_MODE, 'system'));
  Signal<String> get seed => setting((COLOR_SEED, DEFAULT_COLOR));
  Signal<String> get fontScale => setting((FONT_SIZE_FACTOR, "1.0"));
  Signal<String> get contrast => setting((CONTRAST_VALUE, DEFAULT_CONTRAST));
  Signal<String> get displayHeadlineFont => setting((DISPLAY_FONT, "Noto Sans"));
  Signal<String> get bodyLabelFont => setting((BODY_FONT, "Noto Sans"));
  Signal<String> get variant => setting((VARIANT, "tonalSpot")); //TODO

  // Signal<ColorSeed> get colorSeed {
  //
  //   Color? secondarySeed = (await prefs.getInt(COLOR_SECONDARY_SEED)).toColor();
  //   Color? tertiarySeed = (await prefs.getInt(COLOR_TERTIARY_SEED)).toColor();
  //   Color? neutralSeed = (await prefs.getInt(COLOR_NEUTRAL_SEED)).toColor();
  //   Color? neutralVariantSeed = (await prefs.getInt(COLOR_NV_SEED)).toColor();
  //   Color? errorSeed = (await prefs.getInt(COLOR_ERROR_SEED)).toColor();
  // }

  void dispose() {
      _cleanup?.call();
      setting.dispose();
    }


    Future <bool> monochrome() async {
      bool? isMonochrome = await prefs.getBool(MONOCHROME);
      if (isMonochrome == null) {
        return false;
      } else
        return isMonochrome;
    }

  }

extension Converters on String {
  ThemeMode toThemeMode() {
    switch(this) {
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