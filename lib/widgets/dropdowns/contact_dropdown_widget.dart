import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';

/// A dropdown widget for selecting a contact subject.
///
/// This widget displays a dropdown button for selecting a contact subject from a list of available options.
/// It allows the user to choose a subject and triggers a callback when an item is selected.
///
/// The [contactUsSubjectDropDownValue] parameter is the initial value of the dropdown.
/// The [onItemSelected] parameter is a callback function triggered when an item is selected.
/// The [focusNode] parameter is an optional [FocusNode] used to manage the focus of the dropdown.
class ContactDropdown extends StatefulWidget {
  const ContactDropdown({
    Key? key,
    required this.contactUsSubjectDropDownValue,
    required this.onItemSelected,
    this.focusNode,
  }) : super(key: key);

  final String? contactUsSubjectDropDownValue;
  final Function onItemSelected;
  final FocusNode? focusNode;

  @override
  State<StatefulWidget> createState() => ContactDropdownState();
}

/// The state of the [ContactDropdown] widget.
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
