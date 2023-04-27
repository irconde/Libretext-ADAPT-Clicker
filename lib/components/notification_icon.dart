import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../app_state.dart';
import '../backend/router/app_router.gr.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class notificationIcon extends StatelessWidget {
  const notificationIcon({super.key, required this.setState,});
  
  //Imported Variables
  final StateSetter setState;

  @override
  Widget build(BuildContext context) {
    int val = FFAppState().notificationCount();
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
            style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryBackground),
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
