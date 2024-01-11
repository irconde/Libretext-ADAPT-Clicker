import 'package:adapt_clicker/constants/icons.dart';
import 'package:flutter/material.dart';
import '../../constants/strings.dart';
import '../../main.dart';
import '../../utils/logger.dart';
import '../notification_icon_widget.dart';

/// The main app bar widget.
import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget  {
  const MainAppBar({
    Key? key,
    required this.title,
    required this.scaffoldKey,
    required this.setState,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final StateSetter setState;
  final String title;
  final dynamic scaffoldKey;

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        tooltip: 'Main Menu',
        icon: Icon(Icons.menu),
        onPressed: () {
          widget.scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(widget.title),
      actions: [
        NotificationIcon(
          setState: widget.setState,
        ),
      ],
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

}
