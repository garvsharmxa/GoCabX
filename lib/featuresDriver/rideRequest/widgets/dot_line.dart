

import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final Axis direction; // Horizontal or Vertical
  final double dashWidth;
  final double dashHeight;
  final double spacing;
  final Color color;

  const DottedLine({
    Key? key,
    this.direction = Axis.horizontal,
    this.dashWidth = 5,
    this.dashHeight = 1,
    this.spacing = 2,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final length = direction == Axis.horizontal
            ? constraints.maxWidth
            : constraints.maxHeight;

        final dashCount = (length / (dashWidth + spacing)).floor();
        return Flex(
          direction: direction,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: direction == Axis.horizontal ? dashWidth : dashHeight,
              height: direction == Axis.horizontal ? dashHeight : dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
