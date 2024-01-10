import 'package:adapt_clicker/backend/firebase/firebase_api.dart';
import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:flutter_svg/svg.dart';
import '../../../backend/Router/app_router.dart';
import '../../../constants/colors.dart';
import '../../../utils/app_theme.dart';
import '../../../constants/dimens.dart';
import 'package:flutter/material.dart';


class NotificationSingle extends StatefulWidget {
  const NotificationSingle({Key? key, required this.index, required this.message}) : super(key: key);

  /// The index of the notification.
  final int index;
  final FirebaseMessage message;

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
                  '${widget.message.title}',
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
                widget.message.body!,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: CColors.secondaryText,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            const Divider(
              height: Dimens.dividerHeight,
              thickness: Dimens.dividerThickness,
              endIndent: 30,
            ),
          ],
        ),
    );
  }
}
