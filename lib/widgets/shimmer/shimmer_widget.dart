import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color shimmerColor;
  final List<Widget>? children;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor = CColors.mainShimmerBackground,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.shimmerColor = CColors.shimmerColor,
    this.children,
  }) : super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor = CColors.mainShimmerBackground,
    this.shapeBorder = const CircleBorder(),
    this.shimmerColor =  CColors.shimmerColor,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Shimmer.fromColors(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children ?? [],
              ),
            ),
          ),
      ]
    );

  }
}
