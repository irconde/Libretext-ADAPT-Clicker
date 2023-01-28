import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

class TimezoneDropdown extends StatefulWidget {
  TimezoneDropdown({Key? key, required this.timezoneDropDownValue})
      : super(key: key);
  String? timezoneDropDownValue;

  void initState() {
    if (timezoneDropDownValue == null)
      timezoneDropDownValue = AppState.timezoneContainer!.textzones.first;
  }

  @override
  State<StatefulWidget> createState() => TimezoneDropdownState();
}

class TimezoneDropdownState extends State<TimezoneDropdown> {
  String? timezoneDropDownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: FlutterFlowTheme.of(context).textFieldBorder,
        ),
        color: FlutterFlowTheme.of(context).textFieldBackground,
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: timezoneDropDownValue,
          isExpanded: true,
          items: AppState.timezoneContainer?.textzones.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            );
          }).toList(),
          dropdownColor: FlutterFlowTheme.of(context).textFieldBackground,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              timezoneDropDownValue = value;
              AppState.userTimezone!.setText(value.toString());
              AppState.userTimezone!.setValue(
                  AppState.timezoneContainer!.getValue(value.toString()));
            });
          },
          style: FlutterFlowTheme.of(context).bodyText1,
          underline: Container(),
          hint: Text(
            AppState.userTimezone!.text,
            style: FlutterFlowTheme.of(context).bodyText1,
          ),
        ),
      ),
    );
  }
}
