import 'package:adapt_clicker/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget{
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? shimmerColor;
  final Widget? child;

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
    this.backgroundColor,
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
      color: backgroundColor ?? FlutterFlowTheme.of(context).primaryColor,
      child: child,
    ),
  );

}