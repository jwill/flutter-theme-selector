import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/settings_service.dart';
import 'package:signals/signals_flutter.dart';

import '../constants.dart';
import '../font_constants.dart';
import '../settings_controller.dart';

class FontSelector extends StatelessWidget {
  final SettingsController controller;
  final SettingsSignalsService service;

  const FontSelector(
      {super.key,
      required this.controller, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final notifier = service.fontScale.toValueNotifier();

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Display Headline Font",
              style: textTheme.bodyLarge,
            ),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200),
              child: DropdownSearch<String>(
                selectedItem: controller.displayHeadlineFont,
                items: googleFontsList,
                onChanged: (newValue) =>
                    controller.updateFonts(DISPLAY_FONT, newValue),
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
                selectedItem: controller.bodyLabelFont,
                items: googleFontsList,
                onChanged: (newValue) {
                    controller.updateFonts(BODY_FONT, newValue);
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
                value: double.parse(notifier.value),
                min: 1,
                max: MAX_FONT_SIZE_FACTOR,
                divisions: MAX_FONT_SIZE_FACTOR.toInt() * 10,
                label: service.fontScale.value.toString(),
                onChanged: (value){
                  service.fontScale.value = value.toString();
                  //controller.updateFontSizeFactor(value);
                }),
          ],
        )
      ],
    );
  }
}
