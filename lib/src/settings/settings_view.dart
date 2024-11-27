import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/font_constants.dart';
import 'package:flutter_theme_selector/src/settings/settings_service.dart';
import 'package:flutter_theme_selector/src/settings/widgets/color_field.dart';
import 'package:flutter_theme_selector/src/settings/widgets/font_selector.dart';
import 'package:flutter_theme_selector/src/settings/widgets/theme_chooser_panel.dart';
import 'package:flutter_theme_selector/src/settings/widgets/themeable_pie.dart';
import 'package:flutter_theme_selector/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals_flutter.dart';

import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  SettingsView({super.key, required this.signals});

  static const routeName = '/settings';

  final SettingsSignalsService signals;
  //var fontSizeFactor = 0.0;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final contrastNotifier = widget.signals.contrast.toValueNotifier();

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
                    style: textTheme.bodyLarge,
                  ),
                  Spacer(),
                  DropdownButton<String>(
                    // Read the selected themeMode from the controller
                    value: widget.signals.themeMode.value,
                    // Call the updateThemeMode method any time the user selects a theme.
                    onChanged: (v) => widget.signals.themeMode.value = v!,
                    items: const [
                      DropdownMenuItem(
                        value: "system",
                        child: Text('System Theme'),
                      ),
                      DropdownMenuItem(
                        value: "light",
                        child: Text('Light Theme'),
                      ),
                      DropdownMenuItem(
                        value: "dark",
                        child: Text('Dark Theme'),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              FontSelector(service: widget.signals),
              SizedBox(
                height: 16,
              ),
              Divider(),
              SizedBox(
                height: 16,
              ),
              ColorField(
                  color: int.parse(widget.signals.seed.value).toColor()!,
                  title: "Seed Color",
                  onChanged: (color) {
                    setState(() {
                      widget.signals.seed.value = color.value.toString();
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
                        selectedItem: widget.signals.variant.value,
                        items: DynamicSchemeVariant.values.map((v) {
                          return v.name;
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            widget.signals.variant.value = newValue!;
                            //widget.controller.updateSeedColor(COLOR_SEED, widget.controller.colorSeed.seed.value);
                          });
                        }))
              ]),
              Row(
                children: [
                  Text(
                    "Contrast",
                    style: textTheme.bodyLarge,
                  ),
                  Spacer(),
                  Slider(
                      value: double.parse(contrastNotifier.value),
                      min: -1,
                      max: 1,
                      divisions: 20,
                      label: widget.signals.contrast.value.toString(),
                      onChanged: (value){
                        widget.signals.contrast.value = value.toString();
                        //widget.signals.contrast.value = value.toString();
                      }),
                ],
              ),
              Divider(),
              ThemeChooserPanel(
                onTap: (String value) {
                  //TODO make a function that allows passing the whole scheme in case we have
                  // constructed schemes that don't just use a seed color
                  //widget.controller.updateSeedColor("seed", value);
                  widget.signals.seed.value = value;
                },
                schemes: [
                  ColorScheme.fromSeed(seedColor: Colors.blue, contrastLevel: double.parse(contrastNotifier.value)),
                  ColorScheme.fromSeed(seedColor: Colors.green, contrastLevel: double.parse(contrastNotifier.value)),
                  ColorScheme.fromSeed(seedColor: Colors.yellow, contrastLevel: double.parse(contrastNotifier.value))
                ],
              ),
              Divider(),
              ThemeChooserPanel(
                displayOnlyPrimary: true,
                onTap: (value) {
                  //TODO make a function that allows passing the whole scheme in case we have
                  // constructed schemes that don't just use a seed color
                  print(value);
                  widget.signals.seed.value = value;
                },
                schemes: [
                  ColorScheme.fromSeed(seedColor: Colors.blue, contrastLevel: double.parse(contrastNotifier.value)),
                  ColorScheme.fromSeed(seedColor: Colors.green, contrastLevel: double.parse(contrastNotifier.value)),
                  ColorScheme.fromSeed(seedColor: Colors.yellow, contrastLevel: double.parse(contrastNotifier.value))
                ],
              ),
            ],
          )),
    );
  }
}
