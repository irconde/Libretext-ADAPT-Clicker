import 'package:adapt_clicker/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget{
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? shimmerColor;
  final Widget? child;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
    this.backgroundColor,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.shimmerColor,
    this.child,
});

  const ShimmerWidget.circular({
    this.width = double.infinity,
    required this.height,
    this.backgroundColor,
    this.shapeBorder = const CircleBorder(),
    this.shimmerColor,
    this.child,
});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: backgroundColor ?? FlutterFlowTheme.of(context).primaryColor,
    highlightColor: shimmerColor ?? FlutterFlowTheme.of(context).lightPrimaryColor,
    child: Container(
      width: width,
      height: height, // grey
      decoration: ShapeDecoration(
        color: backgroundColor ?? FlutterFlowTheme.of(context).primaryColor,
        shape: shapeBorder,
      ),

      child: child,
    ),
  );

}