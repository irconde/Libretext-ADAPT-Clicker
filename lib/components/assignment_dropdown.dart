import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../utils/constants.dart';
import 'filter_sheet.dart';

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
      backgroundColor: const Color(0x0E1862B3),
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
              color: FlutterFlowTheme.of(context).textFieldBorder,
            ),
            borderRadius:
                const BorderRadius.all(Radius.circular(Constants.xxsMargin)),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    _value ?? widget.itemList?.first ?? '',
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
