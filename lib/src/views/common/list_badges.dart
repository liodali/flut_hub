import 'package:flut_hub/src/views/common/badge_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListBadges extends StatelessWidget {
  final List<BadgeFilter> badges;
  final Axis direction;
  final bool isScrollable;

  const ListBadges({
    Key? key,
    required this.badges,
    this.direction = Axis.horizontal,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = badges
        .map(
          (badge) => Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: badge,
          ),
        )
        .toList();
    return SingleChildScrollView(
      physics: isScrollable ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
      child: direction == Axis.horizontal
          ? Row(
              children: children,
            )
          : Column(
              children: children,
            ),
    );
  }
}
