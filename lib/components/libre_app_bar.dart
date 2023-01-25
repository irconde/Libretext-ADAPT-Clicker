import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gen/assets.gen.dart';

class LibreAppBar extends StatefulWidget {
  const LibreAppBar({Key? key, required this.titleNoSpace, required this.titleSpace, this.top = 0.0, required this.iconPath, this.svgIconColor}) : super(key: key);

  final String titleNoSpace;
  final String titleSpace;
  final String iconPath;
  final double top;
  final Color? svgIconColor;

  @override
  _LibreAppBarState createState() => _LibreAppBarState(top, titleNoSpace, titleSpace, iconPath, svgIconColor);
}




class _LibreAppBarState extends State<LibreAppBar>  {
  _LibreAppBarState(this.top, this.titleNoSpace, this.titleSpace, this.iconPath, this.svgIconColor);
  ApiCallResponse? logout;
  double top;
  String titleNoSpace;
  String iconPath;
  final String titleSpace;
  Color? svgIconColor;

  @override
  void initState() {
    // TODO: implement initState
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
        leadingWidth: Constants.mmMargin,
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
    if (topSize <= Constants.appBarTransitionHeight) {
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

  EdgeInsetsGeometry getPadding(var top)
  {
    if(checkTop(top))
      return  EdgeInsetsDirectional.fromSTEB(Constants.xlMargin, 0, 0, Constants.smMargin);
    else
      return  EdgeInsetsDirectional.fromSTEB(Constants.mmMargin, 0, 0, Constants.mmMargin);

  }
}