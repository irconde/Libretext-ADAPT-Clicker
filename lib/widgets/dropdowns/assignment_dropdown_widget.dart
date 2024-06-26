import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../../constants/dimens.dart';
import '../bottom_sheets/filter_sheet_widget.dart';

/// A dropdown widget for selecting an assignment.
///
/// This widget displays a dropdown button for selecting an assignment from a list of available options.
/// It allows the user to choose an assignment and triggers a callback when an item is selected.
///
/// The [selectedItem] parameter is the initial value of the dropdown.
/// The [itemList] parameter is the list of available items for selection.
/// The [onItemSelectedCallback] parameter is a callback function triggered when an item is selected.
class AssignmentDropdown extends StatefulWidget {
  const AssignmentDropdown({
    Key? key,
    required String? dropDownValue,
    required this.semanticsLabel,
    required this.itemList,
    required this.onItemSelectedCallback,
  })  : selectedItem = dropDownValue,
        super(key: key);

  final String semanticsLabel;
  final String? selectedItem;
  final List<String>? itemList;
  final Function(String) onItemSelectedCallback;

  @override
  State<StatefulWidget> createState() => AssignmentDropdownState();
}

/// The state of the [AssignmentDropdown] widget.
class AssignmentDropdownState extends State<AssignmentDropdown> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.selectedItem;
  }

  void onFilterOptionSelected(filterOption) {
    widget.onItemSelectedCallback(filterOption);
    setState(() {
      _value = filterOption;
    });
  }

  void showFilterOptions() {
    showModalBottomSheet<void>(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: CColors.blurColor,
      context: context,
      builder: (context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: FilterSheet(
                listSemanticsLabel: widget.semanticsLabel,
                filterOptions: widget.itemList!,
                onItemSelectedCallback: onFilterOptionSelected));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Semantics(
      label: widget.semanticsLabel,
      child: GestureDetector(
        onTap: showFilterOptions,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Container(
            height: 36,
            width: 172,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: CColors.textFieldBorder,
              ),
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimens.xxsMargin)),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      (_value ?? widget.itemList?.first ?? '').toUpperCase(),
                      style: theme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: CColors.tertiaryText,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: CColors.tertiaryColor,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
