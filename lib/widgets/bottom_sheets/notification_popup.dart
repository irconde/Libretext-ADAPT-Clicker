import 'package:adapt_clicker/backend/Router/app_router.dart';
import 'package:adapt_clicker/widgets/buttons/custom_button_widget.dart';
import 'package:auto_route/auto_route.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'blurred_bottom_sheet.dart';

/// Widget for adding a course.
class NotificationPopup extends StatelessWidget {
  const NotificationPopup(this.title, this.body, this.route, {Key? key }) : super(key: key);

  final String title;
  final String? body;
  final String route;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: BlurredBottomSheet(
        centered: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notifications_active,
                      color: CColors.primaryColor,
                      size: Dimens.notificationPopupIconSize,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(Dimens.xsMargin, 0, 0, 0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: theme.subtitle1.override(
                          fontFamily: 'Open Sans',
                          color: CColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 48,
                  thickness: 1,
                  color: CColors.lineColor,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    body!,
                    textAlign: TextAlign.start,
                    style: theme.bodyText2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, Dimens.msMargin, 0, 0),
                      child: CustomButtonWidget(
                        text: Strings.ignoreButton,
                        options: ButtonOptions(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              Dimens.sMargin, 0, Dimens.sMargin, 0),
                          textStyle: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            color: CColors.primaryColor,
                          ),
                          color: CColors.primaryBackground,
                          elevation: 0,
                          borderRadius: const BorderRadius.all(Radius.zero),

                        ),
                        onPressed: () { context.router.pop();},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Dimens.smMargin, Dimens.msMargin, 0, 0),
                      child: CustomButtonWidget(
                        text: Strings.participateButton,
                        options: ButtonOptions(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              Dimens.sMargin, 0, Dimens.sMargin, 0),
                          height: Dimens.buttonHeight,
                          textStyle: theme.title2.override(
                            fontFamily: 'Open Sans',
                            fontSize: Dimens.defaultTextSize,
                          ),
                          color: CColors.primaryColor,
                          elevation: 0,
                          borderRadius: const BorderRadius.all(Radius.zero),

                        ),
                        onPressed: ()
                        {
                          context.router.pop();
                          RouteHandler.navTo(route);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
