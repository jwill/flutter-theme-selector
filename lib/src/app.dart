import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_theme_selector/src/settings/settings_service.dart';
import 'package:flutter_theme_selector/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals_flutter.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.settingsService,
  });

  final SettingsSignalsService settingsService;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.

    Signal<String> themeMode = settingsService.themeMode;
    Signal<String> fontScale = settingsService.fontScale;
    Signal<String> displayFont = settingsService.displayHeadlineFont;
    Signal<String> bodyFont = settingsService.bodyLabelFont;
    Signal<String> seed = settingsService.seed;
    Signal<String> variant = settingsService.variant;

    return Watch.builder(builder: (context) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(double.parse(fontScale
                  .value))), //double.parse(settingsService.fontScale.value))),
          child: MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,

            theme: ThemeData(
                textTheme:
                createTextTheme(context, bodyFont, displayFont).value,
                //TODO
                colorScheme:
                colorScheme(Brightness.light, seed, variant).value),
            darkTheme: ThemeData(
                textTheme: createTextTheme(context, bodyFont, displayFont).value
                    .apply(
                    bodyColor: ColorScheme
                        .fromSeed(
                        seedColor: int.parse(seed.value).toColor()!,
                        brightness: Brightness.dark)
                        .onSurface),
                colorScheme:
                colorScheme(Brightness.dark, seed, variant).value),
            themeMode: themeMode.value.toThemeMode(),
            debugShowCheckedModeBanner: false,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(
                        signals: settingsService,
                      );
                    case SampleItemDetailsView.routeName:
                      return const SampleItemDetailsView();
                    case SampleItemListView.routeName:
                    default:
                      return const SampleItemListView();
                  }
                },
              );
            },
          ));
    });
  }
}
