import 'package:adapt_clicker/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? shimmerColor;
  final Widget? child;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.shimmerColor,
    this.child,
  }) : super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor,
    this.shapeBorder = const CircleBorder(),
    this.shimmerColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: backgroundColor ?? AppTheme.of(context).primaryColor,
        highlightColor: shimmerColor ?? AppTheme.of(context).lightPrimaryColor,
        child: Container(
          width: width,
          height: height, // grey
          decoration: ShapeDecoration(
            color: backgroundColor ?? AppTheme.of(context).primaryColor,
            shape: shapeBorder,
          ),

          child: child,
        ),
      );
}
