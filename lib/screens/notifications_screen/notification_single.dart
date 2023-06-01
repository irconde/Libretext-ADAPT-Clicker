import 'package:flutter_svg/svg.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';

class NotificationSingle extends StatefulWidget {
  const NotificationSingle({Key? key, required this.index}) : super(key: key);

  /// The index of the notification.
  final int index;

  @override
  State<NotificationSingle> createState() => _NotificationSingleWidgetState();
}

/// The state for the [NotificationSingle] widget.
class _NotificationSingleWidgetState extends State<NotificationSingle> {
  _NotificationSingleWidgetState();

  /// Indicates whether the notification has been dismissed.
  bool dismissed = false;

  /// The key value for the widget.
  dynamic keyVal = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.mmMargin, Dimens.msMargin, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    0, 0, Dimens.xxsMargin, 0),
                child: SvgPicture.asset(
                  'assets/images/book_icon.svg',
                  height: 24,
                  width: 24,
                ),
              ),
              Text(
                '${Strings.notification} ${widget.index}',
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: CColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Dimens.mmMargin, Dimens.xsMargin, 0, Dimens.msMargin),
            child: Text(
              Strings.details,
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: CColors.secondaryText,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: Dimens.dividerThickness,
            endIndent: 30,
          ),
        ],
      ),
    );
  }
}
