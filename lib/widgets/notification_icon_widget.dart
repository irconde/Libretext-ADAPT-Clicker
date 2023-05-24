import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../backend/push_notification_manager.dart';
import '../backend/router/app_router.gr.dart';
import '../constants/colors.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, required this.setState,});
  
  //Imported Variables
  final StateSetter setState;

  @override
  Widget build(BuildContext context) {
    int val = PushNotificationManager().notificationCount();
    if (val == 0) {
      return IconButton(
        icon: const Icon(
          Icons.notifications,
        ),
        onPressed: () async {
          context
              .pushRoute(const NotificationsRouteWidget())
              .then((_) => setState(() {}));
        },
      );
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 6),
          badgeContent: Text(
            '$val',
            style: const TextStyle(
                color: CColors.primaryBackground),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () async {
              context
                  .pushRoute(const NotificationsRouteWidget())
                  .then((_) => setState(() {}));
            },
          ),
        ),
      );
    }
  }


}
