import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';

class ContactDropdown extends StatefulWidget {
  const ContactDropdown(
      {Key? key,
      required this.contactUsSubjectDropDownValue,
      required this.onItemSelected,
      this.focusNode})
      : super(key: key);
  final String? contactUsSubjectDropDownValue;
  final Function onItemSelected;
  final FocusNode? focusNode;
  @override
  State<StatefulWidget> createState() => ContactDropdownState();
}

class ContactDropdownState extends State<ContactDropdown> {
  String? contactUsSubjectDropDownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: CColors.textFieldBorder,
          ),
          color: CColors.textFieldBackground,
        ),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: contactUsSubjectDropDownValue,
            isExpanded: true,
            focusNode: widget.focusNode!,
            items: <String>[
              Strings.generalInquiry,
              Strings.technicalIssue,
              Strings.emailChange,
              Strings.requestInstructorAccessCode,
              Strings.requestTesterAccessCode,
              Strings.integratingADAPT,
              Strings.other
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.of(context).bodyText1,
                ),
              );
            }).toList(),
            dropdownColor: CColors.textFieldBackground,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                contactUsSubjectDropDownValue = value!;
              });
              widget.onItemSelected(value!);
            },
            style: AppTheme.of(context).bodyText1,
            underline: Container(),
            hint: Text(
              Strings.generalInquiry,
              style: AppTheme.of(context).bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
