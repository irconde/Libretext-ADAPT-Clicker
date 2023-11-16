import 'package:adapt_clicker/constants/dimens.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';


/// A widget displayed when there is no learning path available.
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
            child: Container(
              color: CColors.learningEmptyListTitleBackground,
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
                              text: Strings.assessment,
                              style: theme.title2.override(
                                color: CColors.primaryColor,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ]),
                    ),
                    Text(
                      Strings.records,
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
    );
  }
}

/// Widget representing an empty learning task.
Widget emptyLearningTask() {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, 0, Dimens.msMargin, Dimens.xsMargin),
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
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.standardBorderRadius))),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(Dimens.sMargin, Dimens.sMargin, Dimens.msMargin-4, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.smMargin, 0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const ShapeDecoration(
                          color: CColors.learningSquareColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(Dimens.standardBorderRadius))),
                        ),
                      ),
                    ),
                    Container(
                      height: 16,
                      width: 156,
                      decoration: const ShapeDecoration(
                        color: CColors.learningTopTextContainerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Dimens.standardBorderRadius))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, Dimens.sMargin, 0, Dimens.xsMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.xsMargin, 0),
                        child: Container(
                          width: 80,
                          height: 16,
                          decoration: const ShapeDecoration(
                            color: CColors.learningBtmTextContainerColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(Dimens.standardBorderRadius))),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 156,
                        decoration: const ShapeDecoration(
                          color: CColors.learningBtmTextContainerColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(Dimens.standardBorderRadius))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Dimens.mmMargin,
            height: Dimens.mmMargin,
            decoration: const ShapeDecoration(
              color: CColors.learningSquareColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.standardBorderRadius))),
            ),
          )
        ],
      ),
    ),
  );
}
