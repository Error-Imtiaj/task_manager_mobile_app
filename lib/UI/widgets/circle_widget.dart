import 'package:flutter/material.dart';

class Circlewidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? right;
  final double? top;
  final double? left;
  final double? bottom;
  final Color? color;
  final Widget? child;

  const Circlewidget(
      {super.key,
      this.width,
      this.height,
      this.right,
      this.top,
      this.left,
      this.bottom,
      this.child,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      top: right,
      left: left,
      bottom: bottom,
      child: child ??
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color,
            ),
            width: width,
            height: height,
          ),
    );
  }
}
