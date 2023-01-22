import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../gen/assets.gen.dart';

class AssignmentDropdown extends StatefulWidget {
  const AssignmentDropdown(
      {Key? key, required this.dropDownValue, required this.dropDownList})
      : super(key: key);
  final String? dropDownValue;
  final List<String>? dropDownList;

  @override
  State<StatefulWidget> createState() =>
      AssignmentDropdownState(dropDownValue, dropDownList);
}

class AssignmentDropdownState extends State<AssignmentDropdown> {
  AssignmentDropdownState(this.dropDownValue, this.dropDownList);

  String? dropDownValue;
  List<String>? dropDownList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Container(
        height: 36,
        width: 172,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: FlutterFlowTheme.of(context).textFieldBorder,
          ),
          borderRadius: BorderRadius.all(Radius.circular(Constants.xxsMargin)),
          color: Colors.transparent,
        ),
        child: ButtonTheme(
            alignedDropdown: false,
            child: DropdownButton<String>(
              value: dropDownValue ?? dropDownList?.first,
              isExpanded: true,
              items: dropDownList?.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).tertiaryText),
                    ),
                  ),
                );
              }).toList(),
              dropdownColor: FlutterFlowTheme.of(context).textFieldBackground,
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropDownValue = value!;
                });
              },
              style: FlutterFlowTheme.of(context).bodyText1,
              underline: Container(),
              hint: Text(
                dropDownList?.first ?? '',
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            )),
      ),
    );
  }
}
