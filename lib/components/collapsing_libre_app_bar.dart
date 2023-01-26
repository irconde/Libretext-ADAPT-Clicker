import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gen/assets.gen.dart';

class CollapsingLibreAppBar extends StatefulWidget {
  const CollapsingLibreAppBar({Key? key, required this.titleNoSpace, required this.titleSpace, this.top = 0.0, required this.iconPath, this.svgIconColor}) : super(key: key);

  final String titleNoSpace;
  final String titleSpace;
  final String iconPath;
  final double top;
  final Color? svgIconColor;

  @override
  _CollapsingLibreAppBarState createState() => _CollapsingLibreAppBarState(top, titleNoSpace, titleSpace, iconPath, svgIconColor);
}




class _CollapsingLibreAppBarState extends State<CollapsingLibreAppBar>  {
  _CollapsingLibreAppBarState(this.top, this.titleNoSpace, this.titleSpace, this.iconPath, this.svgIconColor);
  ApiCallResponse? logout;
  double top;
  String titleNoSpace;
  String iconPath;
  final String titleSpace;
  Color? svgIconColor;

  @override
  void initState() {
    super.initState();
    if(svgIconColor == null)
      svgIconColor = FlutterFlowTheme.of(context).svgIconColor;
  }

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        expandedHeight: Constants.appBarHeight,
        pinned: true,
        snap: false,
        floating: false,
        shadowColor: FlutterFlowTheme.of(context).tertiaryColor,
        leading: IconButton(icon: Icon(Icons.arrow_back, size: 24),
          onPressed: () async
      {
        Navigator.of(context).pop();
      },),
        flexibleSpace: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints constraints) {
          top = constraints.biggest.height;
          return FlexibleSpaceBar(
            titlePadding: getPadding(top),
            title: Text(getTitle(top),
                style: FlutterFlowTheme.of(context).title2),
            background: Align(
             alignment: Alignment(0,.5),
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.scaleDown,
                color: svgIconColor,
              ),
            ),
          );
        })
    );
  }


  //This determines the title and padding switch
  bool checkTop(var topSize) {
    if (topSize <= Constants.appBarHeight) {
      return true;
    } else {
      return false;
    }
  }

  String getTitle(var top){
    if(checkTop(top))
      return titleNoSpace;
    else
      return titleSpace;
  }

  double getTransition(double diff)
  {
    double result = 32 + Constants.xlMargin - diff;

    if(result < 32)
      return 32;

    if(result > Constants.xlMargin)
      return Constants.xlMargin;

    return result;
  }
  EdgeInsetsGeometry getPadding(var top)
  {

    if(checkTop(top)) {
      double diff = (top -  Constants.appBarTransitionMin)/Constants.appBarTitleSpeed + Constants.appBarTitleOffset;

      return EdgeInsetsDirectional.fromSTEB(getTransition(diff), 0, 0, Constants.smMargin);

    }
    else
      return  EdgeInsetsDirectional.fromSTEB(Constants.mmMargin, 0, 0, Constants.mmMargin);

  }


}