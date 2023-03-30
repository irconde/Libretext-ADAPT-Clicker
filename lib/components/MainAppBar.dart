import 'package:adapt_clicker/app_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../flutter_flow/app_router.gr.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.title, required this.scaffoldKey, required this.setState})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  //Imported Variables
  final Function setState;
  final String title;
  final dynamic scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(title),
      actions: [
        notificationIcon(context),
      ],
    );
  }

  Widget notificationIcon(BuildContext context) {
    int val = FFAppState().notificationCount();
    StatefulWidget page;
    if (val == 0) {
      return IconButton(
        icon: const Icon(
          Icons.notifications,
        ),
        onPressed: () async {
          context.pushRoute(const NotificationsRouteWidget());
        },
      );
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 6),
          badgeContent: Text('$val'),
          child: IconButton(
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () async {
              context.pushRoute(const NotificationsRouteWidget()).then((_) =>
                  setState(() {}));
            },
          ),
        ),
      );
    }
  }


}
