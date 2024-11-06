import 'package:flutter/material.dart';

class MaterialIcon extends StatelessWidget {
  const MaterialIcon(
      this.icon, {
        Key? key,
        this.size = 24,
        this.color,
      }) : super(key: key);

  final IconData icon;
  final double size;
  final Color? color;
  static bool isFigma = false;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
    // if (kDebugMode || !isFigma) {
    //   return Icon(
    //     icon,
    //     size: size,
    //     color: color,
    //   );
    // }
    // return SizedBox.square(
    //   dimension: size,
    //   child: Stack(
    //     clipBehavior: Clip.none,
    //     children: [
    //       Positioned(
    //         top: -1,
    //         right: 1,
    //         child: Icon(
    //           icon,
    //           size: size - 2,
    //           weight: 100,
    //           opticalSize: size,
    //           grade: 25,
    //           fill: 0,
    //           color: color,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}