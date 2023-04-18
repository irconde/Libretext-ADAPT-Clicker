import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../utils/constants.dart';

class AssignmentDropdown extends StatefulWidget {
  const AssignmentDropdown(
      {Key? key,
      required String? dropDownValue,
      required this.itemList,
      required this.onItemSelectedCallback})
      : selectedItem = dropDownValue,
        super(key: key);
  final String? selectedItem;
  final List<String>? itemList;
  final Function(String) onItemSelectedCallback;

  @override
  State<StatefulWidget> createState() => AssignmentDropdownState();
}

class AssignmentDropdownState extends State<AssignmentDropdown> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.selectedItem;
  }

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
          borderRadius:
              const BorderRadius.all(Radius.circular(Constants.xxsMargin)),
          color: Colors.transparent,
        ),
        child: ButtonTheme(
            alignedDropdown: false,
            child: DropdownButton<String>(
              value: _value ?? widget.itemList?.first,
              isExpanded: true,
              items: widget.itemList?.map((String value) {
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
                widget.onItemSelectedCallback(value!);
                setState(() {
                  _value = value;
                });
              },
              style: FlutterFlowTheme.of(context).bodyText1,
              underline: Container(),
              hint: Text(
                widget.itemList?.first ?? '',
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            )),
      ),
    );
  }
}
