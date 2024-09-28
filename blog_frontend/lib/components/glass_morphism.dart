
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism(
      {super.key,
      this.borderRadius,
      required this.child,
      this.containerColor,
      this.containerBorderColor,
      this.containerOpacity,
      this.containerBorderOpacity});
  final double? containerOpacity;
  final double? containerBorderOpacity;

  final double? borderRadius;
  final Color? containerColor;
  final Color? containerBorderColor;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: containerColor ??
              Colors.white.withOpacity(
                containerOpacity ?? 0.2,
              ),
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          border: Border.all(
            color: containerBorderColor ??
                containerColor ??
                Colors.white.withOpacity(
                    containerBorderOpacity ?? containerOpacity ?? 0.2),
            width: 1.5,
          )),
      child: child,
    );
  }
}
