import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class NoLearningPathWidget extends StatefulWidget {
  const NoLearningPathWidget({Key? key}) : super(key: key);

  @override
  State<NoLearningPathWidget> createState() => _NoLearningPathWidgetState();
}

class _NoLearningPathWidgetState extends State<NoLearningPathWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Stack(
      children: [
        Column(children: List.generate(6, (index) => emptyLearningTask())),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 134, 0, 0),
          child: Align(
            alignment: Alignment.bottomCenter,
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
                          text: Strings.assessment,
                          style: theme.bodyText1.override(
                            color: CColors.primaryColor,
                            fontFamily: 'Open Sans',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ]),
                ),
                Text(Strings.records, style: theme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    fontSize: 24,
                    color: CColors.primaryColor),),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget emptyLearningTask() {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 23, 8),
    child: Container(
      color: CColors.learningBackgroundContainerColor,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 88,
            decoration: const ShapeDecoration(
              color: CColors.learningLeftStatBar,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2))),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const ShapeDecoration(
                          color: CColors.learningSquareColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ),
                    Container(
                      height: 16,
                      width: 156,
                      decoration: const ShapeDecoration(
                        color: CColors.learningTopTextContainerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Container(
                          width: 80,
                          height: 16,
                          decoration: const ShapeDecoration(
                            color: CColors.learningBtmTextContainerColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 156,
                        decoration: const ShapeDecoration(
                          color: CColors.learningBtmTextContainerColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const ShapeDecoration(
              color: CColors.learningSquareColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2))),
            ),
          )
        ],
      ),
    ),
  );
}
