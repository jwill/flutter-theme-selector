import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  Future<ThemeMode> themeMode() async {
    int? state = await prefs.getInt("themeMode");
    if (state == null || state == 2) return ThemeMode.system;
    if (state == 0) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  Future<double> contrast() async => 0.0;

  Future<void> loadSettings() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode mode) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    switch (mode) {
      case ThemeMode.light:
        prefs.setInt("themeMode", 0);
        break;
      case ThemeMode.dark:
        prefs.setInt("themeMode", 1);
        break;
      case ThemeMode.system:
        prefs.setInt("themeMode", 2);
        break;
    }
  }


  Future <String> displayHeadlineFont() async {
    String? displayFont = await prefs.getString(DISPLAY_FONT);
    if (displayFont == null) {
      return 'Abril Fatface';
    }
    else {
      return displayFont;
    }
  }

  Future <String> bodyLabelFont() async {
    String? bodyFont = await prefs.getString(BODY_FONT);
    if (bodyFont == null) {
      return 'Abril Fatface';
    }
    else {
      return bodyFont;
    }
  }

  Future<void> updateDisplayFont(String newValue) async {
    String? displayFont = await prefs.getString(DISPLAY_FONT);
    if (newValue != displayFont) {
      prefs.setString(DISPLAY_FONT, newValue);
    }
  }

  Future<void> updateBodyFont(String newValue) async {
    String? bodyFont = await prefs.getString(BODY_FONT);
    if (newValue != bodyFont) {
      prefs.setString(BODY_FONT, newValue);
    }
  }
}