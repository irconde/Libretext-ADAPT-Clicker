import 'package:adapt_clicker/app_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../backend/router/app_router.gr.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'notification_icon.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.title, required this.scaffoldKey, required this.setState})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  //Imported Variables
  final StateSetter setState;
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
        notificationIcon(setState: setState,),
      ],
    );
  }




}
