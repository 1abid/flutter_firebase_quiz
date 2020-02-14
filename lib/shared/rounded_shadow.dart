import 'package:flutter/material.dart';
import 'dart:math';

class RoundedShadow extends StatelessWidget {
  final Widget child;
  final Color shadowColor;

  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  const RoundedShadow({
    Key key,
    this.shadowColor,
    this.topLeftRadius = 48,
    this.topRightRadius = 48,
    this.bottomLeftRadius = 48,
    this.bottomRightRadius = 48,
    this.child,
  }) : super(key: key);

  const RoundedShadow.fromRadius(double radius,
      {Key key, this.child, this.shadowColor})
      : topRightRadius = radius,
        topLeftRadius = radius,
        bottomRightRadius = radius,
        bottomLeftRadius = radius;

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.only(
      topLeft: Radius.circular(topLeftRadius),
      topRight: Radius.circular(topRightRadius),
      bottomLeft: Radius.circular(bottomLeftRadius),
      bottomRight: Radius.circular(bottomRightRadius),
    );

    var maxRadius = [
      topRightRadius,
      topLeftRadius,
      bottomRightRadius,
      bottomLeftRadius,
    ].reduce(max);

    var sColor = shadowColor ?? Color(0x20000000);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [new BoxShadow(color: sColor, blurRadius: maxRadius * .5)]
      ),
      child: ClipRRect(borderRadius: radius,child: child),
    );
  }
}
