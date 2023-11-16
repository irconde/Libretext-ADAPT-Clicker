import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../constants/dimens.dart';
import '../../../utils/app_theme.dart';
import 'package:flutter/material.dart';

class NoNotificationsWidget extends StatefulWidget {
  const NoNotificationsWidget({Key? key}) : super(key: key);

  @override
  State<NoNotificationsWidget> createState() => _NoNotificationsWidgetState();
}

/// The state for the [NoNotificationsWidget].
class _NoNotificationsWidgetState extends State<NoNotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.xlMargin),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExcludeSemantics(
            child: SvgPicture.asset(
              'assets/images/no_notifications.svg',
              width: double.infinity,
              height: 300,
              fit: BoxFit.none,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.noNotifications,
                style: AppTheme.of(context).title2.override(
                      fontFamily: 'Open Sans',
                      color: CColors.primaryColor,
                      fontSize: 28,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.forNow,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: CColors.primaryColor,
                      fontSize: 28,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
