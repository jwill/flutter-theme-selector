import 'dart:math';

import 'package:flutter/material.dart';

class ThemeablePieWidget extends StatelessWidget {
  ThemeablePieWidget(
      {Key? key, required this.scheme, required this.isSelected, this.isSingleColor = false});

  final ColorScheme scheme;
  final bool isSelected;
  // To display only a single color (like M2 ColorScheme)
  bool isSingleColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      size: Size.square(100.0),
      painter: ThemeablePiePainter(scheme: scheme, isSelected: this.isSelected,
          isSingleColor:this.isSingleColor),
    );
  }

}

class ThemeablePiePainter extends CustomPainter {
  ThemeablePiePainter({required this.scheme, this.isSelected = false,
    this.isSingleColor = false});

  ColorScheme scheme;
  bool isSelected;
  final selectedIcon = Icons.check;

  // To display only a single color (like M2 ColorScheme)
  bool isSingleColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (isSingleColor) {
     canvas.save();
     canvas.drawArc(Rect.fromLTWH(0, 0, 100, 100), 0, 2 * pi, true,
         Paint()..color = scheme.primary);
     canvas.save();

    } else {
      canvas.save();
      canvas.drawArc(Rect.fromLTWH(0, 0, 100, 100), 0, pi / 2, true,
          Paint()
            ..color = scheme.tertiary);
      canvas.drawArc(Rect.fromLTWH(0, 0, 100, 100), pi / 2, pi / 2, true,
          Paint()
            ..color = scheme.secondary);
      canvas.drawArc(
          Rect.fromLTWH(0, 0, 100, 100), 2 * pi / 2, 2 * pi / 2, true,
          Paint()
            ..color = scheme.primary);

      canvas.save();
    }
    if (isSelected) {
      canvas.translate(25, 25);
      canvas.drawArc(Rect.fromLTWH(0, 0, 50, 50), 0, 2 * pi, true,
          Paint()..color = scheme.primaryContainer);
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: String.fromCharCode(selectedIcon.codePoint),
        style: TextStyle(
          color: scheme.onPrimaryContainer,
          fontSize: 24,
          fontFamily: selectedIcon.fontFamily,
          package: selectedIcon
              .fontPackage, // This line is mandatory for external icon packs
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(12.5, 12.5));
    }

    canvas.restore();
    canvas.restore();
    //canvas.drawCircle(
    //    Offset(0,0), 150, Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
