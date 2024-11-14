import 'package:flutter/material.dart';

import 'constants.dart';
import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  late double _contrast;

  late String _displayHeadlineFont;
  late String _bodyLabelFont;
  late double _fontSizeFactor;
  late ColorSeed _colorSeed;

  late bool _monochrome;

  late DynamicSchemeVariant _variant;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;
  String get displayHeadlineFont => _displayHeadlineFont;
  String get bodyLabelFont => _bodyLabelFont;

  double get fontSizeFactor => _fontSizeFactor;

  ColorSeed get colorSeed => _colorSeed;

  double get contrast => _contrast;

  ColorScheme colorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(seedColor: _colorSeed.seed, brightness: brightness, dynamicSchemeVariant: _variant);
  }

  bool get monochrome => _monochrome;

  DynamicSchemeVariant get variant => _variant;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    print(_themeMode);
    _contrast = await _settingsService.contrast();
    _displayHeadlineFont = await _settingsService.displayHeadlineFont();
    _bodyLabelFont = await _settingsService.bodyLabelFont();
    _fontSizeFactor = await _settingsService.fontSizeFactor();
    _colorSeed = await _settingsService.colorSeed();
    _monochrome = await _settingsService.monochrome();
    _variant = await _settingsService.variant();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  // Single seed
  Future<void> updateSeedColor(String key, int? newValue) async {
    if (newValue == null) return;

    _colorSeed = ColorSeed("", Color(newValue));
    await _settingsService.updateSeedColor(newValue);
    notifyListeners();
  }

  Future<void> updateFonts(String key, String? newValue) async {
    if (newValue == null) return;

    print(key);
    if (key == DISPLAY_FONT) {
      _displayHeadlineFont = newValue;
      await _settingsService.updateDisplayFont(newValue);
      notifyListeners();
    }
    if (key == BODY_FONT) {
      _bodyLabelFont = newValue;
      await _settingsService.updateBodyFont(newValue);
      notifyListeners();
    }

    notifyListeners();
  }
  Future<void> updateFontSizeFactor(double? newValue) async {
    if (newValue == null) return;

    _fontSizeFactor = newValue;
    await _settingsService.updateFontSizeFactor(newValue);
    notifyListeners();
  }

  Future<void> updateContrast(double? newValue) async {
    if (newValue == null) return;

    _contrast = newValue;
    await _settingsService.updateContrast(newValue);
    notifyListeners();
  }

  Future<void> updateVariant(String variant, String? newValue) async {
    if (newValue == null) return;

    _variant = DynamicSchemeVariant.values.firstWhere((v) {return newValue == v.name;});
    await _settingsService.updateVariant(newValue);
  }
}
