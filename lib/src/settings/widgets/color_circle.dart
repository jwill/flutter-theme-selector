import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({
    Key? key,
    required this.color,
    this.selected = false,
    this.onPressed,
  }) : super(key: key);

  final Color color;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          border:
          selected ? Border.all(color: colors.onPrimary, width: 2) : null,
        ),
      ),
    );
  }
}