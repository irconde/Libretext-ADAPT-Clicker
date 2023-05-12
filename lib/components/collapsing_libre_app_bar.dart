import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';
import 'notification_icon.dart';

class CollapsingLibreAppBar extends StatefulWidget {
  const CollapsingLibreAppBar(
      {Key? key,
      required this.title,
      this.top = 0.0,
      this.child,
      this.iconPath,
      this.svgIconColor,
      this.showNotificationIcon = false})
      : super(key: key);

  final String title;
  final String? iconPath;
  final double top;
  final Widget? child;
  final Color? svgIconColor;
  final bool showNotificationIcon;

  @override
  State<CollapsingLibreAppBar> createState() => _CollapsingLibreAppBarState();
}

class _CollapsingLibreAppBarState extends State<CollapsingLibreAppBar> {
  ApiCallResponse? logout;
  double? a;
  Color? iconColor;
  double top = 0.0;
  String? titleSpace;

  @override
  void initState() {
    super.initState();
    iconColor =
        widget.svgIconColor ?? FlutterFlowTheme.of(context).svgIconColor;
    top = widget.top;
    titleSpace = formatExpandedTitle(widget.title);
  }

  String formatExpandedTitle(String regularTitle) {
    String expandedTitle = '';
    int numWords = regularTitle.split(' ').length;
    switch (numWords) {
      case 1:
        expandedTitle = regularTitle;
        break;
      case 2:
        expandedTitle = regularTitle.replaceFirst(' ', '\n');
        break;
      default:
        expandedTitle =
            regularTitle.replaceFirst(' ', '\n', regularTitle.indexOf(' ') + 1);
    }
    return expandedTitle;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.child == null)
    {
      return _mySliverAppbar();
    }
    return CustomScrollView(

        slivers: [
      _mySliverAppbar(),

     SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: 1, (context, index) => ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: widget.child,
          )
          )),
    ]
    );
  }

  Widget _mySliverAppbar() => SliverAppBar(
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      expandedHeight: Constants.appBarHeight,
      pinned: true,
      snap: false,
      floating: true,
      elevation: 4,
      shadowColor: FlutterFlowTheme.of(context).tertiaryColor,
      actions: [
        widget.showNotificationIcon
            ? notificationIcon(setState: (VoidCallback fn) {
          setState(fn);
        })
            : Container(),
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 24),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
        },
      ),
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            top = constraints.biggest.height;
            return FlexibleSpaceBar(
              titlePadding: getPadding(),
              title: Text(getTitle(),
                  maxLines: checkTop() ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: getTitleStyle()),
              background: widget.iconPath != null
                  ? Align(
                alignment: const Alignment(0, .5),
                child: SvgPicture.asset(
                  widget.iconPath!,
                  fit: BoxFit.scaleDown,
                  color: iconColor,
                ),
              )
                  : null,
            );
          }));

  //This determines the title and padding switch
  bool checkTop() {
    if (top <= Constants.appBarHeight) {
      return true;
    } else {
      return false;
    }
  }

  String getTitle() {
    return checkTop() ? widget.title : titleSpace!;
  }

  TextStyle getTitleStyle() {
    double transitionVal = 4;
    if (checkTop()) {
      transitionVal = ((top / Constants.appBarTransitionMin) /
              (264 / Constants.appBarTransitionMin)) *
          4; //264 is max appbar size (max + 24 I believe).
    }

    double result = 20 + transitionVal;
    FontWeight fw;
    if (transitionVal < 1.25) {
      fw = FontWeight.w600;
    } else if (transitionVal < 2) {
      fw = FontWeight.w700;
    } else if (transitionVal < 2.5) {
      fw = FontWeight.w800;
    } else {
      fw = FontWeight.w900; // Extra Bold
    }

    return FlutterFlowTheme.of(context).title3.override(
          fontFamily: 'Open Sans',
          fontSize: result,
          fontWeight: fw,
        );
  }

  double getTransition(double diff) {
    double result = 32 + Constants.xlMargin - diff;
    if (result < 32) return 32;
    if (result > Constants.xlMargin) return Constants.xlMargin;
    return result;
  }

  EdgeInsetsGeometry getPadding() {
    if (checkTop()) {
      double diff = getDiff();
      return EdgeInsetsDirectional.fromSTEB(getTransition(diff), 0, 0,
          Constants.smMargin + 1); // +1 made text align better with arrow.
    } else {
      return const EdgeInsetsDirectional.fromSTEB(
          Constants.mmMargin, 0, 0, Constants.mmMargin);
    }
  }

  double getDiff() {
    return (top - Constants.appBarTransitionMin) / Constants.appBarTitleSpeed +
        Constants.appBarTitleOffset;
  }
}
