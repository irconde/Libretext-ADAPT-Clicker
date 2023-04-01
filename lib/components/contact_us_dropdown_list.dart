import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class ContactUsDropDownList extends StatefulWidget {
  const ContactUsDropDownList(
      {Key? key, required this.contactUsSubjectDropDownValue, required this.onItemSelected})
      : super(key: key);
  final String? contactUsSubjectDropDownValue;
  final Function onItemSelected;
  @override
  State<StatefulWidget> createState() => ContactUsDropDownListState();
}

class ContactUsDropDownListState extends State<ContactUsDropDownList> {
  String? contactUsSubjectDropDownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
      child: Container(
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
            value: contactUsSubjectDropDownValue,
            isExpanded: true,
            items: <String>[
              'General Inquiry',
              'Technical Issue',
              'Email Change',
              'Request Instructor Access Code',
              'Request Tester Access Code',
              'Integrating ADAPT with LMS',
              'Other'
            ].map((String value) {
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
                contactUsSubjectDropDownValue = value!;
              });
              widget.onItemSelected(value!);
            },
            style: FlutterFlowTheme.of(context).bodyText1,
            underline: Container(),
            hint: Text(
              'General Inquiry',
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
