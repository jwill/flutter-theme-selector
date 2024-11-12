import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/font_constants.dart';
import 'package:flutter_theme_selector/src/settings/settings_service.dart';
import 'package:flutter_theme_selector/src/settings/widgets/color_field.dart';
import 'package:flutter_theme_selector/src/settings/widgets/theme_chooser_panel.dart';
import 'package:flutter_theme_selector/src/settings/widgets/themeable_pie.dart';

import 'constants.dart';
import 'settings_controller.dart';
import 'package:google_fonts/google_fonts.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;
  //var fontSizeFactor = 0.0;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  double fontSizeFactor = 1.0;
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
                  Text(
                    "Theme Mode",
                    style: textTheme.titleMedium,
                  ),
                  Spacer(),
                  DropdownButton<ThemeMode>(
                    // Read the selected themeMode from the controller
                    value: widget.controller.themeMode,
                    // Call the updateThemeMode method any time the user selects a theme.
                    onChanged: widget.controller.updateThemeMode,
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
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text("Display Headline Font"),
                  Spacer(),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: DropdownSearch<String>(
                      selectedItem: widget.controller.displayHeadlineFont,
                      items: googleFontsList,
                      onChanged: (newValue) =>
                          widget.controller.updateFonts(DISPLAY_FONT, newValue),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "Body Label Font",
                    style: textTheme.bodyLarge,
                  ),
                  Spacer(),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: DropdownSearch<String>(
                      selectedItem: widget.controller.bodyLabelFont,
                      items: googleFontsList,
                      onChanged: (newValue) {
                        setState(() {
                          widget.controller.updateFonts(BODY_FONT, newValue);
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "Font Scale",
                    style: textTheme.bodyLarge,
                  ),
                  Spacer(),
                  Slider(
                      value: widget.controller.fontSizeFactor,
                      min: 1,
                      max: MAX_FONT_SIZE_FACTOR,
                      divisions: MAX_FONT_SIZE_FACTOR.toInt() * 10,
                      label: fontSizeFactor.toString(),
                      onChanged: (double value) {
                        setState(() {
                          fontSizeFactor = value;
                          widget.controller.updateFontSizeFactor(value);
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Themes",
                style: textTheme.bodyLarge,
              ),
              SizedBox(
                height: 8,
              ),
              ColorField(
                  color: widget.controller.colorSeed.seed,
                  title: "Seed Color",
                  onChanged: (color) {
                    setState(() {
                      widget.controller.updateSeedColor("seed", color.value);
                    });
                  }),
              SizedBox(
                height: 16,
              ),
              Row(children: [
                Text(
                  "Dynamic Variant",
                  style: textTheme.bodyLarge,
                ),
                Spacer(),
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: DropdownSearch<String>(
                        selectedItem: widget.controller.variant.name,
                        items: DynamicSchemeVariant.values.map((v) {
                          return v.name;
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            widget.controller.updateVariant(VARIANT, newValue);
                            widget.controller.updateSeedColor(COLOR_SEED, widget.controller.colorSeed.seed.value);
                          });
                        }))
              ]),
              Divider(),
              ThemeChooserPanel(
                onTap: (value) {
                  //TODO make a function that allows passing the whole scheme in case we have
                  // constructed schemes that don't just use a seed color
                  widget.controller.updateSeedColor("seed", value);
                },
                schemes: [
                  ColorScheme.fromSeed(seedColor: Colors.blue),
                  ColorScheme.fromSeed(seedColor: Colors.green),
                  ColorScheme.fromSeed(seedColor: Colors.yellow)
                ],
              ),
            ],
          )),
    );
  }
}
