import 'package:adapt_clicker/constants/icons.dart';
import 'package:flutter/material.dart';
import '../../constants/strings.dart';
import '../notification_icon_widget.dart';

/// The main app bar widget.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [MainAppBar] widget.
  ///
  /// The [title] is the text to display as the app bar title.
  /// The [scaffoldKey] is the key of the scaffold widget used to open the drawer.
  /// The [setState] is a callback to update the state of the parent widget.
  const MainAppBar({
    Key? key,
    required this.title,
    required this.scaffoldKey,
    required this.setState,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  /// The callback to update the state of the parent widget.
  final StateSetter setState;

  /// The text to display as the app bar title.
  final String title;

  /// The key of the scaffold widget used to open the drawer.
  final dynamic scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        tooltip: Strings.mainMenuSemanticsLabel,
        icon: IIcons.menu,
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(title),
      actions: [
        NotificationIcon(
          setState: setState,
        ),
      ],
    );
  }
}
