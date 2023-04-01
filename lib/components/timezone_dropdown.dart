import 'package:flutter/material.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

class TimezoneDropdown extends StatefulWidget {
  TimezoneDropdown(
      {Key? key,
      required this.timezoneDropDownValue,
      this.onItemSelectedCallback})
      : super(key: key);
  String? timezoneDropDownValue;
  Function? onItemSelectedCallback;

  @override
  State<StatefulWidget> createState() =>
      TimezoneDropdownState(timezoneDropDownValue);
}

Future<void> fetchTimezone() async {
  final response = await GetTimezonesCall.call(); //contact server

  if (response.succeeded) {
    // If the call to the server was successful, init timezones
    initTimezones(response.jsonBody);
  } else {
    // If that call was not successful, throw an error.
    throw Exception(getJsonField(response.jsonBody,
        r'''$.message''')); //message should give error message.
    //note all errors will be logged in backend for server-side fix
  }
}

class TimezoneDropdownState extends State<TimezoneDropdown> {
  String? timezoneDropDownValue;

  TimezoneDropdownState(this.timezoneDropDownValue);

  Future<void> timezoneInit() async {
    await fetchTimezone();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: timezoneInit(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                items:
                    AppState.timezoneContainer?.textZones.map((String value) {
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
                  if (widget.onItemSelectedCallback != null) {
                    widget.onItemSelectedCallback!(timezoneDropDownValue);
                  }
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
        });
  }
}
