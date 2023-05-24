import 'package:flutter_svg/svg.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';

class NotificationSingle extends StatefulWidget {
  const NotificationSingle({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<NotificationSingle> createState() => _NotificationSingleWidgetState();
}

class _NotificationSingleWidgetState extends State<NotificationSingle> {
  _NotificationSingleWidgetState();
  bool dismissed = false;

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
                'Notification ${widget.index}',
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
              'Details',
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
