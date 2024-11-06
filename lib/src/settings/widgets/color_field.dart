import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/utils.dart';

import 'color_circle.dart';
import 'color_picker.dart';
import 'material_icon.dart';

class ColorField extends StatelessWidget {
  const ColorField({
    Key? key,
    required this.color,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onChanged,
  }) : super(key: key);

  final Color color;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fonts = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.onInverseSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 2),
          ColorCircle(
            color: color,
            onPressed: () => openColorPicker(context),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: fonts.titleMedium!.copyWith(
                      color: colors.onSurface,
                    )),
                if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                  Text(subtitle!,
                      style: fonts.bodySmall!.copyWith(
                        color: colors.onSurface,
                      )).opacity(0.68),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            trailing!,
            const SizedBox(width: 10),
          ] else ...[
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }

  void openColorPicker(BuildContext context) {
    Color _color = this.color;
    final colors = Theme.of(context).colorScheme;
    final fonts = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, update) => AlertDialog(
            title: Text(
              'HCT Color Picker',
              style: fonts.apply(fontFamily: "Noto Sans").displaySmall!.copyWith(color: colors.onSurface),
            ),
            backgroundColor: colors.surface,
            titleTextStyle: fonts.displaySmall!.copyWith(
              color: colors.onSurface,
            ),
            icon: MaterialIcon(Icons.color_lens),
            iconColor: _color,
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: ColorPicker(
                  color: _color,
                  onChanged: (color) {
                    update(() => _color = color);
                  },
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  onChanged(_color);
                  Navigator.pop(context);
                },
                child: Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }
}