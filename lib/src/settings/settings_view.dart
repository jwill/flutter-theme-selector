import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/font_constants.dart';
import 'package:flutter_theme_selector/src/settings/settings_service.dart';

import 'constants.dart';
import 'settings_controller.dart';
import 'package:google_fonts/google_fonts.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          // Glue the SettingsController to the theme selection DropdownButton.
          //
          // When a user selects a theme from the dropdown list, the
          // SettingsController is updated, which rebuilds the MaterialApp.
          child: Column(
            children: [
              Row(
                children: [
                  Text("Theme Mode", style: textTheme.titleMedium,),
                  Spacer(),
                  DropdownButton<ThemeMode>(
                    // Read the selected themeMode from the controller
                    value: controller.themeMode,
                    // Call the updateThemeMode method any time the user selects a theme.
                    onChanged: controller.updateThemeMode,
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark Theme'),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(children: [
                Text("Display Headline Font"),
                Spacer(),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: 200), child:
                DropdownSearch<String>(selectedItem: controller.displayHeadlineFont,
                  items: googleFontsList,
                    onChanged: (newValue)=>
                    controller.updateFonts(DISPLAY_FONT, newValue),
                ),
                )],),
              SizedBox(height: 16,),
              Row(children: [
                Text("Body Label Font", style: textTheme.bodyLarge,),
                Spacer(),
                ConstrainedBox(constraints: BoxConstraints(maxWidth: 200), child:
                DropdownSearch<String>(
                  selectedItem: controller.bodyLabelFont,
                  items: googleFontsList,
                  onChanged: (newValue)=>
                  controller.updateFonts(BODY_FONT, newValue)
                ,
                ),
                )],)
            ],
          )),
    );
  }
}
