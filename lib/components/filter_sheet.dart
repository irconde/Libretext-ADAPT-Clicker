import 'dart:ui';
import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/flutter_flow/flutter_flow_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'form_state_mixin.dart';

class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet( {Key? key, required this.filterOptions, required this.onItemSelectedCallback}) : super(key: key);

  final List<String> filterOptions;
  final Function(String) onItemSelectedCallback;

  @override
  ConsumerState<FilterSheet> createState() =>
      _FilterSheet();
}

class _FilterSheet extends ConsumerState<FilterSheet>
    with TickerProviderStateMixin, FormStateMixin, ConnectionStateMixin {


  @override
  Widget build(BuildContext context) {
    var theme = FlutterFlowTheme.of(context);
    return InkWell(
      onTap: () async {
        context.popRoute();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.blurColor,
          ),
          alignment: const AlignmentDirectional(0, 1),
          child: InkWell(
            onTap: () async {}, //keeps actual background not clicking
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: theme.secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.filterOptions.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: () {
                            widget.onItemSelectedCallback(widget.filterOptions[index]);
                            setState(() {
                            });
                            context.popRoute();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  widget.filterOptions[index],
                                  style: theme.bodyText2
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                            ],
                          ),
                        );
                      }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

