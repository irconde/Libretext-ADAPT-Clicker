import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../../constants/dimens.dart';
import '../bottom_sheets/filter_sheet_widget.dart';

class AssignmentDropdown extends StatefulWidget {
  const AssignmentDropdown({
    Key? key,
    required String? dropDownValue,
    required this.itemList,
    required this.onItemSelectedCallback,
  })  : selectedItem = dropDownValue,
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
                filterOptions: widget.itemList!,
                onItemSelectedCallback: onFilterOptionSelected));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return GestureDetector(
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
    );
  }
}
