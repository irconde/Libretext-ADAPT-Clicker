import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_state.dart';

class TimezoneDropdown extends StatefulWidget {
  TimezoneDropdown(
      {Key? key,
      required this.timezoneDropDownValue,
      this.onItemSelectedCallback,
      this.focusNode})
      : super(key: key);
  String? timezoneDropDownValue;
  Function? onItemSelectedCallback;
  FocusNode? focusNode;

  @override
  State<StatefulWidget> createState() => TimezoneDropdownState();
}

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