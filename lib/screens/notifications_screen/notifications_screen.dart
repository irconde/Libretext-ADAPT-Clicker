import 'package:adapt_clicker/backend/push_notification_manager.dart';
import 'package:adapt_clicker/screens/notifications_screen/no_notifications_widget.dart';
import 'package:adapt_clicker/screens/notifications_screen/notification_single.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

void createList() {
  if (PushNotificationManager().notificationList.isEmpty) return;
}

void addNotification(String details) {
  PushNotificationManager().addNotification(details);
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    //createList();
    //addNotification('details');
  }

  void clearNotifications() {
    setState(() {
      PushNotificationManager().clearNotifications();
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CColors.primaryBackground,
            size: 24,
          ),
          onPressed: () async {
            Navigator.pop(context, '/');
          },
        ),
        title: const Text('Notifications'),
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
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ),
                            onDismissed: (_) {
                              setState(() {
                                PushNotificationManager()
                                    .removeNotification(index);
                              });
                            },
                            child: NotificationSingle(
                              index: index,
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

  bool notificationEmpty() {
    return true;
  }
}

// Clear All
class ClearAllWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  const ClearAllWidget({Key? key, required this.isActive, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isActive ? CColors.primaryBackground : CColors.clearAllColor;

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Clear All ',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (isActive) {
                  onTap();
                }
              },
            style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
