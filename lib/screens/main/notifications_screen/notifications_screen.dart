import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:flutter/material.dart';
import 'package:adapt_clicker/backend/push_notification_manager.dart';
import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/screens/main/notifications_screen/no_notifications_widget.dart';
import 'package:adapt_clicker/screens/main/notifications_screen/notification_single.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import '../../../backend/firebase/firebase_api.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_theme.dart';
import '../../../constants/dimens.dart';


@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

/// Creates the list of notifications.
void createList() {
  if (PushNotificationManager().notificationList.isEmpty) return;
}

/// Adds a new notification to the list.
void addNotification(FirebaseMessage message) {
  PushNotificationManager().addNotification(message);
}

class _NotificationsScreenState extends State<NotificationsScreen> with WidgetsBindingObserver{
  //Local
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: Strings.backButtonSemanticsLabel,
          icon: IIcons.back,
          onPressed: () async {
            Navigator.pop(context, '/');
          },
        ),
        title: const Text(Strings.notifications),
        actions: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.sMargin, 0),
              child: ClearAllWidget(
                  isActive:
                      PushNotificationManager().notificationList.isNotEmpty,
                  onTap: clearNotifications),
            ),
          ),
        ],
      ),
      backgroundColor: CColors.primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PushNotificationManager().notificationList.isEmpty
                    ? const Align(
                        alignment: Alignment.bottomCenter,
                        child: NoNotificationsWidget())
                    : ListView.builder(
                        itemCount:
                            PushNotificationManager().notificationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dismissibleKey = UniqueKey();
                          return InkWell(
                            onTap: () async
                            {
                              FirebaseAPI api = FirebaseAPI();
                              Map<String, dynamic>? parsedData = api.parseLink('${PushNotificationManager().getNotification(index).route}');
                              api.isOutside = true;
                              await api.handleParsed(parsedData, null);
                              PushNotificationManager().removeNotification(index);
                              await PushNotificationManager().resetNotificationList();
                              setState(() {});
                            },
                            child: Dismissible(
                              key: dismissibleKey,
                              background:  Container(
                                    color: CColors.delete,
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: Dimens.sMargin),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ),
                              secondaryBackground: Container(
                                color: CColors.delete,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: Dimens.sMargin),
                                    child: Icon(Icons.delete),
                                  ),
                                ),
                              ),
                              onDismissed: (_) async {
                                PushNotificationManager().removeNotification(index);
                                await PushNotificationManager().resetNotificationList();
                                setState(() {});
                              },
                              child: NotificationSingle(
                                index: index,
                                message: PushNotificationManager().getNotification(index),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///Functions
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await Future.delayed(const Duration(milliseconds: 150));
      setState((){});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  /// Clears all notifications from the list.
  void clearNotifications() async {
    await PushNotificationManager().clearNotifications();
    await PushNotificationManager().resetNotificationList();
    setState(() {});
  }

  /// Checks if the notification list is empty.
  bool notificationEmpty() {
    return true;
  }
}

/// Widget for clearing all notifications.
class ClearAllWidget extends StatelessWidget {
  /// Determines whether the "Clear All" button is active or not.
  final bool isActive;

  /// Callback function invoked when the "Clear All" button is tapped.
  final VoidCallback onTap;

  /// Creates a [ClearAllWidget].
  ///
  /// The [isActive] parameter specifies whether the button is active or not.
  /// The [onTap] parameter is the callback function that is invoked when the button is tapped.
  const ClearAllWidget({
    Key? key,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the text color based on the [isActive] property.
    final color = isActive ? CColors.primaryBackground : CColors.clearAllColor;

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: Strings.clearAllBtnLabel,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (isActive) {
                  onTap();
                }
              },
            style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
