import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_state.dart';

/// A dropdown widget for selecting a timezone.
///
/// This widget displays a dropdown button for selecting a timezone from a list of available options.
/// It allows the user to choose a timezone and triggers a callback when an item is selected.
///
/// The [timezoneDropDownValue] parameter is the initial value of the dropdown.
/// The [onItemSelectedCallback] parameter is a callback function triggered when an item is selected.
/// The [focusNode] parameter is an optional [FocusNode] used to manage the focus of the dropdown.
class TimezoneDropdown extends StatefulWidget {
  TimezoneDropdown({
    Key? key,
    required this.timezoneDropDownValue,
    this.onItemSelectedCallback,
    this.focusNode,
  }) : super(key: key);

  final String? timezoneDropDownValue;
  final Function? onItemSelectedCallback;
  final FocusNode? focusNode;

  @override
  State<StatefulWidget> createState() => TimezoneDropdownState();
}

/// The state of the [TimezoneDropdown] widget.
class TimezoneDropdownState extends State<TimezoneDropdown> {
  String? _timezoneDropDownValue;

  TimezoneDropdownState();

  @override
  void initState() {
    super.initState();
    if (widget.timezoneDropDownValue != null) {
      _timezoneDropDownValue = widget.timezoneDropDownValue;
      AppState.userTimezone.setValue(_timezoneDropDownValue!);
      AppState.userTimezone.setText(AppState.timezoneContainer
          .getText(_timezoneDropDownValue)
          .toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          value: _timezoneDropDownValue,
          isExpanded: true,
          focusNode: widget.focusNode!,
          items: AppState.timezoneContainer.textZones.map((String value) {
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
              _timezoneDropDownValue = value;
              AppState.userTimezone.setText(value.toString());
              AppState.userTimezone.setValue(
                  AppState.timezoneContainer.getValue(value.toString()));
            });
            if (widget.onItemSelectedCallback != null) {
              widget.onItemSelectedCallback!(_timezoneDropDownValue);
            }
          },
          style: AppTheme.of(context).bodyText1,
          underline: Container(),
          hint: Text(
            AppState.userTimezone.text,
            style: AppTheme.of(context).bodyText1,
          ),
        ),
      ),
    );
  }
}
