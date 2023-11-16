import 'package:flutter/material.dart';
import '../../../constants/Dimens.dart';
import '../../../utils/app_theme.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

/// A widget displayed when there are no assignments available.
class NoAssignmentsWidget extends StatefulWidget {
  const NoAssignmentsWidget({Key? key}) : super(key: key);

  @override
  State<NoAssignmentsWidget> createState() => _NoAssignmentsWidgetState();
}

class _NoAssignmentsWidgetState extends State<NoAssignmentsWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.mmMargin),
      child: Stack(
        children: [
          Column(children: List.generate(6, (index) => emptyAssignment())),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: CColors.noAssignmentEmptyListTitleBackground,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.xsMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: theme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                fontSize: Dimens.titleTextSize,
                                color: CColors.primaryColor),
                            children: [
                              const TextSpan(text: Strings.no),
                              TextSpan(
                                text: Strings.assignments,
                                style: theme.title2.override(
                                  color: CColors.primaryColor,
                                  fontFamily: 'Open Sans',
                                ),
                              ),
                            ]),
                      ),
                      Text(
                        Strings.currently,
                        style: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: Dimens.titleTextSize,
                            color: CColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Widget representing an empty assignment.
Widget emptyAssignment() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.sMargin),
                child: Container(
                  decoration: const ShapeDecoration(
                    color: CColors.noAssignmentLeftText,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1))),
                  ),
                  height: 14,
                  width: 100,
                ),
              ),
              Container(
                decoration: const ShapeDecoration(
                  color: CColors.noAssignmentLeftText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1))),
                ),
                height: 8,
                width: 80,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.sMargin),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.smMargin, 0),
                      child: Container(
                        decoration: const ShapeDecoration(
                          color: CColors.noAssignmentRightLeading,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1))),
                        ),
                        height: Dimens.sMargin,
                        width: Dimens.sMargin,
                      ),
                    ),
                    Container(
                      decoration: const ShapeDecoration(
                        color: CColors.noAssignmentRightText,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(1))),
                      ),
                      height: 12,
                      width: 128,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.smMargin, 0),
                    child: Container(
                      decoration: const ShapeDecoration(
                        color: CColors.noAssignmentRightLeading,
                        shape: CircleBorder(),
                      ),
                      height: Dimens.sMargin,
                      width: Dimens.sMargin,
                    ),
                  ),
                  Container(
                    decoration: const ShapeDecoration(
                      color: CColors.noAssignmentRightText,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1))),
                    ),
                    height: 12,
                    width: 80,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      const Divider(
        height: Dimens.mmMargin,
        thickness: Dimens.dividerThickness,
      )
    ],
  );
}
