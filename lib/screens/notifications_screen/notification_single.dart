import 'package:flutter_svg/svg.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

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
          Constants.mmMargin, Constants.msMargin, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    0, 0, Constants.xxsMargin, 0),
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
                      color: AppTheme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Constants.mmMargin, Constants.xsMargin, 0, Constants.msMargin),
            child: Text(
              'Details',
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: AppTheme.of(context).secondaryText,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: Constants.dividerThickness,
            endIndent: 30,
          ),
        ],
      ),
    );
  }
}
