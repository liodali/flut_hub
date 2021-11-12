import 'package:flutter/material.dart';

class BadgeFilter extends StatelessWidget {
  final double elevation;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Widget? icon;
  final Widget title;
  final VisualDensity? density;

  const BadgeFilter({
    Key? key,
    this.elevation = 0.0,
    this.color,
    this.padding,
    this.shape,
    this.density,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: shape,
      backgroundColor: color,
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 5,
          ),
      labelPadding: EdgeInsets.zero,
      avatar: icon,
      label: title,
      visualDensity: density,
    );
  }
}
