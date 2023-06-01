import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

/// Enumeration of shimmer types.
enum ShimmerType {
  /// Shimmer with primary background color.
  primary,

  /// Shimmer with outlined background color.
  outlined,
}

/// A widget that displays a shimmer effect in different shapes and styles.
class ShimmerWidget extends StatelessWidget {
  /// The width of the shimmer container.
  final double width;

  /// The height of the shimmer container.
  final double height;

  /// The background color of the shimmer container.
  final Color backgroundColor;

  /// The color of the shimmer effect.
  final Color shimmerColor;

  /// The list of child widgets to display within the shimmer container.
  final List<Widget>? children;

  /// The shape border of the shimmer container.
  final ShapeBorder shapeBorder;

  /// The type of shimmer to display.
  final ShimmerType type;

  /// Creates a rectangular shimmer widget.
  ///
  /// The [width] specifies the width of the shimmer container.
  /// The [height] specifies the height of the shimmer container.
  /// The [backgroundColor] specifies the background color of the shimmer container.
  /// The [shapeBorder] specifies the shape border of the shimmer container.
  /// The [shimmerColor] specifies the color of the shimmer effect.
  /// The [children] specifies the list of child widgets to display within the shimmer container.
  /// The [type] specifies the type of shimmer to display.
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

  /// Creates a divider shimmer widget.
  ///
  /// The [width] specifies the width of the shimmer container.
  /// The [height] specifies the height of the shimmer container.
  /// The [backgroundColor] specifies the background color of the shimmer container.
  /// The [shapeBorder] specifies the shape border of the shimmer container.
  /// The [shimmerColor] specifies the color of the shimmer effect.
  /// The [children] specifies the list of child widgets to display within the shimmer container.
  /// The [type] specifies the type of shimmer to display.
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

  /// Creates a circular shimmer widget.
  ///
  /// The [width] specifies the width of the shimmer container.
  /// The [height] specifies the height of the shimmer container.
  /// The [backgroundColor] specifies the background color of the shimmer container.
  /// The [shapeBorder] specifies the shape border of the shimmer container.
  /// The [shimmerColor] specifies the color of the shimmer effect.
  /// The [children] specifies the list of child widgets to display within the shimmer container.
  /// The [type] specifies the type of shimmer to display.
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

  /// Builds a primary shimmer widget.
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

  /// Builds an outlined shimmer widget.
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
