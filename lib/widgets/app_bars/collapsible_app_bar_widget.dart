import 'dart:io';
import 'dart:ui';

import '../../backend/api_requests/api_calls.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/dimens.dart';
import '../../constants/colors.dart';
import '../notification_icon_widget.dart';

/// A collapsible app bar widget that can expand and collapse based on scroll position.
class CollapsibleAppBar extends StatefulWidget {
  /// Creates a [CollapsibleAppBar] widget.
  ///
  /// The [title] is the text to display as the app bar title.
  /// The [iconPath] is the path of an SVG icon to display in the background.
  /// The [top] is the initial height of the app bar.
  /// The [child] is an optional widget to display below the app bar.
  /// The [svgIconColor] is the color of the SVG icon. If not specified, it uses the default color.
  /// The [showNotificationIcon] indicates whether to show the notification icon.
  const CollapsibleAppBar(
      {Key? key,
      required this.title,
      this.top = 0.0,
      this.child,
      this.iconPath,
      this.svgIconColor,
      this.showNotificationIcon = false})
      : super(key: key);

  /// The text to display as the app bar title.
  final String title;

  /// The path of an SVG icon to display in the background.
  final String? iconPath;

  /// The initial height of the app bar.
  final double top;

  /// An optional widget to display below the app bar.
  final Widget? child;

  /// The color of the SVG icon. If not specified, it uses the default color.
  final Color? svgIconColor;

  /// Indicates whether to show the notification icon.
  final bool showNotificationIcon;

  @override
  State<CollapsibleAppBar> createState() => _CollapsibleAppBarState();
}

class _CollapsibleAppBarState extends State<CollapsibleAppBar> {
  ApiCallResponse? logout;
  double? a;
  Color? iconColor;
  double top = 0.0;
  String? titleSpace;

  @override
  void initState() {
    super.initState();
    iconColor = widget.svgIconColor ?? CColors.svgIconColor;
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
    if (widget.child == null) {
      return _mySliverAppbar();
    }
    return CustomScrollView(slivers: [
      _mySliverAppbar(),
      SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: widget.child,
                  ))),
    ]);
  }

  Widget _mySliverAppbar() => SliverAppBar(
      backgroundColor: CColors.primaryColor,
      expandedHeight: Dimens.appBarHeight,
      pinned: true,
      snap: false,
      floating: true,
      elevation: 4,
      shadowColor: CColors.tertiaryColor,
      actions: [
        widget.showNotificationIcon
            ? NotificationIcon(setState: (VoidCallback fn) {
                  setState(fn);
                },
            )
            : Container(),
      ],
      leading: Semantics(
        label:  Strings.backButtonSemanticsLabel,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
        ),
      ),
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        top = constraints.biggest.height - 20;
        return FlexibleSpaceBar(
          titlePadding: getPadding(),
          centerTitle: false,
          collapseMode: CollapseMode.none,
          title: Text(getTitle(),
              maxLines: checkTop() ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: getTitleStyle()),
          background: widget.iconPath != null
              ? ExcludeSemantics(
                child: Align(
                    alignment: const Alignment(0, .5),
                    child: SvgPicture.asset(
                      widget.iconPath!,
                      fit: BoxFit.scaleDown,
                      color: iconColor,
                    ),
                  ),
              )
              : null,
        );
      }));

  //This determines the title and padding switch
  bool checkTop() {
    if (top <= Dimens.appBarHeight) {
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
      transitionVal = ((top / Dimens.appBarTransitionMin) /
              (290 / Dimens.appBarTransitionMin)) *
          4; //290 is max appbar size (max + 26 I believe).
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

    return AppTheme.of(context).title3.override(
          fontFamily: 'Open Sans',
          fontSize: result,
          fontWeight: fw,
        );
  }

  double getTransition(double diff) {
    double result = 32 + Dimens.xlMargin - diff;
    if (result < 32) return 32;
    if (result > Dimens.xlMargin) return Dimens.xlMargin;
    return result;
  }

  EdgeInsetsGeometry getPadding() {
    if (checkTop()) {
      double diff = getDiff();
      return EdgeInsetsDirectional.fromSTEB(getTransition(diff), 0, 0,
          Dimens.smMargin + 1); // +1 made text align better with arrow.
    } else {
      return const EdgeInsetsDirectional.fromSTEB(
          Dimens.mmMargin, 0, 0, Dimens.mmMargin);
    }
  }

  double getDiff() {
    if(top < 84)
      top = 84;

    return (top - Dimens.appBarTransitionMin) / Dimens.appBarTitleSpeed +
        Dimens.appBarTitleOffset;
  }
}
