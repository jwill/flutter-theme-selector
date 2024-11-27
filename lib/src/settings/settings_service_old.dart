import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  //Future<double> contrast() async => 0.0;

  Future<DynamicSchemeVariant> variant() async {
    String? variant = await prefs.getString(VARIANT);
    if (variant == null) return DynamicSchemeVariant.tonalSpot;
    return DynamicSchemeVariant.values.firstWhere((elem) {
      return elem.name == variant;
    }, orElse: () {
      return DynamicSchemeVariant.tonalSpot;
    });
  }

  Future<void> loadSettings() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  }

  Future <ColorSeed> colorSeed() async {
    Color? seed = (await prefs.getInt(COLOR_SEED))?.toColor();
    Color? secondarySeed = (await prefs.getInt(COLOR_SECONDARY_SEED))?.toColor();
    Color? tertiarySeed = (await prefs.getInt(COLOR_TERTIARY_SEED)).toColor();
    Color? neutralSeed = (await prefs.getInt(COLOR_NEUTRAL_SEED)).toColor();
    Color? neutralVariantSeed = (await prefs.getInt(COLOR_NV_SEED)).toColor();
    Color? errorSeed = (await prefs.getInt(COLOR_ERROR_SEED)).toColor();

    if (seed == null) {
      seed = Color(0x6750A4FF);
    }

    return ColorSeed("", seed);
  }

  Future <bool> monochrome() async {
    bool? isMonochrome = await prefs.getBool(MONOCHROME);
    if (isMonochrome == null) {
      return false;
    } else
      return isMonochrome;
  }

  // Future<void> updateDisplayFont(String newValue) async {
  //   String? displayFont = await prefs.getString(DISPLAY_FONT);
  //   if (newValue != displayFont) {
  //     prefs.setString(DISPLAY_FONT, newValue);
  //   }
  // }

  // Future<void> updateBodyFont(String newValue) async {
  //   String? bodyFont = await prefs.getString(BODY_FONT);
  //   if (newValue != bodyFont) {
  //     prefs.setString(BODY_FONT, newValue);
  //   }
  // }

  // Future <void> updateFontSizeFactor(double newValue) async {
  //   double? sizeFactor = await prefs.getDouble(FONT_SIZE_FACTOR);
  //   if (newValue != sizeFactor) {
  //     prefs.setDouble(FONT_SIZE_FACTOR, newValue);
  //   }
  // }

  // Future <void> updateContrast(double newValue) async {
  //   double? contrastSize = await prefs.getDouble(CONTRAST_VALUE);
  //   if (newValue != contrastSize) {
  //     prefs.setDouble(CONTRAST_VALUE, newValue);
  //   }
  // }

  Future <void> updateSeedColor(int newValue) async {
    int? seedColor = await prefs.getInt(COLOR_SEED);
    if (newValue != seedColor) {
      prefs.setInt(COLOR_SEED, newValue);
    }
  }

  Future<void> updateVariant(String newValue) async {
    String? variant = await prefs.getString(VARIANT);
    if (newValue != variant) {
      prefs.setString(VARIANT, newValue);
    }
  }


}