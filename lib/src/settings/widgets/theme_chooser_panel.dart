// Takes in a set of Color Seeds
import 'package:flutter/material.dart';
import 'package:flutter_theme_selector/src/settings/widgets/themeable_pie.dart';
import 'package:flutter_theme_selector/src/utils.dart';

class ThemeChooserPanel extends StatefulWidget {
  final List<ColorScheme> schemes;

  final Function onTap;

  final bool displayOnlyPrimary;

  const ThemeChooserPanel({super.key, required this.onTap,
    required this.schemes, this.displayOnlyPrimary = false});

  @override
  State<ThemeChooserPanel> createState() => _ThemeChooserPanelState();
}

class _ThemeChooserPanelState extends State<ThemeChooserPanel> {
  ColorScheme? _selectedColorScheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width,height: 132, child: ListView.builder(
      itemCount: widget.schemes.length,
        padding: const EdgeInsets.only(top:16, bottom: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
      ColorScheme currentScheme = widget.schemes[index];
      return Padding(padding: const EdgeInsets.only(left: 16, right: 16),
          child: GestureDetector(onTap: (){
            setState(() {
              _selectedColorScheme = currentScheme;
              //TODO make a function that allows passing the whole scheme in case we have
              // constructed schemes that don't just use a seed color
              widget.onTap(_selectedColorScheme!.primary.value);

            });
            },
          child: ThemeablePieWidget(scheme: currentScheme,
            isSelected: currentScheme == _selectedColorScheme,
            isSingleColor: widget.displayOnlyPrimary,)));
    }));
  }
}