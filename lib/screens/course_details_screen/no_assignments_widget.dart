import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

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
      padding: const EdgeInsets.all(32),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: theme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                fontSize: 24,
                                color: CColors.primaryColor),
                            children: [
                              const TextSpan(text: Strings.no),
                              TextSpan(
                                text: Strings.assignments,
                                style: theme.bodyText1.override(
                                  color: CColors.primaryColor,
                                  fontFamily: 'Open Sans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                      Text(
                        Strings.currently,
                        style: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 24,
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Container(
                        decoration: const ShapeDecoration(
                          color: CColors.noAssignmentRightLeading,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(1))),
                        ),
                        height: 16,
                        width: 16,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                    child: Container(
                      decoration: const ShapeDecoration(
                        color: CColors.noAssignmentRightLeading,
                        shape: CircleBorder(),
                      ),
                      height: 16,
                      width: 16,
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
        height: 32,
        thickness: 1,
      )
    ],
  );
}
