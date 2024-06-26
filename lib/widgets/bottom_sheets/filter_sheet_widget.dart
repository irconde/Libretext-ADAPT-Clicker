import 'package:adapt_clicker/constants/dimens.dart';
import 'package:adapt_clicker/widgets/bottom_sheets/blurred_bottom_sheet.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/utils/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../mixins/form_state_mixin.dart';

/// A bottom sheet that displays filter options and allows the user to select an option.
class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({
    Key? key,
    required this.filterOptions,
    required this.listSemanticsLabel,
    required this.onItemSelectedCallback,
  }) : super(key: key);

  /// The list of filter options to display.
  final List<String> filterOptions;
  final String listSemanticsLabel;

  /// Callback function that is called when an item is selected. It takes the selected item as a parameter.
  final Function(String) onItemSelectedCallback;

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheet();
}

class _FilterSheet extends ConsumerState<FilterSheet>
    with TickerProviderStateMixin, FormStateMixin, ConnectionStateMixin {
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return BlurredBottomSheet(
      child: BlockSemantics(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, Dimens.sMargin, Dimens.mmMargin, Dimens.sMargin),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.filterOptions.length,
            itemBuilder: (context, index) {
              return Semantics(
                label:
                    '${widget.listSemanticsLabel}: ${widget.filterOptions[index]}',
                child: InkWell(
                  onTap: () {
                    widget.onItemSelectedCallback(widget.filterOptions[index]);
                    setState(() {});
                    context.popRoute();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimens.xsMargin),
                        child: ExcludeSemantics(
                          child: Text(widget.filterOptions[index],
                              style: theme.bodyText2),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
