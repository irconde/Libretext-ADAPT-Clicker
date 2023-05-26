import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

enum ShimmerType { primary, outlined }

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color shimmerColor;
  final List<Widget>? children;
  final ShapeBorder shapeBorder;
  final ShimmerType type;

  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor = CColors.mainShimmerBackground,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.shimmerColor = CColors.mainShimmerEffect,
    this.children,
    this.type = ShimmerType.primary,
  }) : super(key: key);

  const ShimmerWidget.divider({
    Key? key,
    this.width = double.infinity,
    this.height = 1,
    this.backgroundColor = CColors.mainShimmerBackground,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.shimmerColor = CColors.mainShimmerEffect,
    this.children,
    this.type = ShimmerType.primary,
  }) : super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor = CColors.mainShimmerBackground,
    this.shapeBorder = const CircleBorder(),
    this.shimmerColor = CColors.mainShimmerEffect,
    this.children,
    this.type = ShimmerType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == ShimmerType.primary ? primaryShimmer() : outlinedShimmer();
  }

  Widget primaryShimmer() {
    return Stack(children: [
      Shimmer.fromColors(
        baseColor: backgroundColor,
        highlightColor: shimmerColor,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: shapeBorder,
          ),
        ),
      ),
      Positioned.fill(
        child: Center(
          child: Row(
            children: children ?? [],
          ),
        ),
      ),
    ]);
  }

  Widget outlinedShimmer() {
    return Stack(children: [
      Shimmer.fromColors(
        baseColor: backgroundColor,
        highlightColor: shimmerColor,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: shapeBorder,
          ),
        ),
      ),
      Positioned.fill(
        child: Center(
          child: Row(
            children: children ?? [],
          ),
        ),
      ),
    ]);
  }
}
