// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class OrDivider extends StatefulWidget {
  const OrDivider({
    Key? key,
    this.width,
    this.height,
    required this.label,
    required this.innerDist,
    required this.outerDist,
    this.color,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String label;
  final double innerDist;
  final double outerDist;
  final Color? color;
  @override
  _OrDividerState createState() => _OrDividerState();
}

class _OrDividerState extends State<OrDivider> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(
                left: widget.outerDist, right: widget.innerDist),
            child: Divider(
              color: widget.color,
              height: widget.height,
            )),
      ),
      Text(widget.label.toString()),
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(
                left: widget.outerDist, right: widget.innerDist),
            child: Divider(
              color: Colors.black,
              height: widget.height,
            )),
      ),
    ]);
  }
}
