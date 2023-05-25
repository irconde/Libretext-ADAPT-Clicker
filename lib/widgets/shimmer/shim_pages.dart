import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import '../buttons/custom_elevated_button_widget.dart';
import 'shimmer_widget.dart';

/* -------------------------------- *
 * ------------Profile------------- *
 * -------------------------------- */

final scaffoldKey = GlobalKey<ScaffoldState>();

Widget shimProfile(
    {required StateSetter setState, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const ShapeDecoration(
            color: CColors.secondaryShimmerBackground,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ShimmerWidget.rectangular(
                shapeBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                height: 48,
                backgroundColor: CColors.mainShimmerBackground,
                shimmerColor: CColors.shimmerColor,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: CColors.tertiaryShimmerBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 128, 0),
                      child: Container(
                        height: 12,
                        decoration: const ShapeDecoration(
                          color: CColors.secondaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
          child: Container(
            decoration: const ShapeDecoration(
              color: CColors.secondaryShimmerBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ShimmerWidget.rectangular(
                  shapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  height: 48,
                  backgroundColor: CColors.mainShimmerBackground,
                  shimmerColor: CColors.shimmerColor,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const ShapeDecoration(
                          color: CColors.tertiaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 128, 0),
                        child: Container(
                          height: 12,
                          decoration: const ShapeDecoration(
                            color: CColors.secondaryShimmerBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        Container(
          decoration: const ShapeDecoration(
            color: CColors.secondaryShimmerBackground,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ShimmerWidget.rectangular(
                shapeBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                height: 48,
                backgroundColor: CColors.mainShimmerBackground,
                shimmerColor: CColors.shimmerColor,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: CColors.tertiaryShimmerBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 128, 0),
                      child: Container(
                        height: 12,
                        decoration: const ShapeDecoration(
                          color: CColors.secondaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
          child: Container(
            decoration: const ShapeDecoration(
              color: CColors.secondaryShimmerBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ShimmerWidget.rectangular(
                  shapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  height: 48,
                  backgroundColor: CColors.mainShimmerBackground,
                  shimmerColor: CColors.shimmerColor,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const ShapeDecoration(
                          color: CColors.tertiaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 128, 0),
                        child: Container(
                          height: 12,
                          decoration: const ShapeDecoration(
                            color: CColors.secondaryShimmerBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        Expanded(
          child: Text(
            Strings.requiredFields,
            style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: CColors.primaryColor,
                  fontSize: Dimens.requiredTextSize,
                ),
          ),
        ),
        CustomElevatedButton(
          type: ButtonType.shimmer,
          normalText: Strings.updateProfileBtnLabel,
          errorText: Strings.tryAgainBtnLabel,
          successText: Strings.updateProfileBtnSuccessLabel,
          processingText: Strings.updateProfileBtnProcessingLabel,
          onPressed: () {},
        ),
      ],
    ),
  );
}

/* -------------------------------- *
 * ------------Courses------------- *
 * -------------------------------- */

Widget shimCourses(
    {required StateSetter setState, required BuildContext context}) {
  return SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 32),
        child: Column(
            children: List.generate(15, (index) {
          return const Column(children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 32, 96, 12),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1))),
                height: 14,
                backgroundColor: CColors.buttonShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 156, 24),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1))),
                height: 12,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
            ShimmerWidget.rectangular(
              height: 1,
              backgroundColor: CColors.mainShimmerBackground,
              shimmerColor: CColors.shimmerColor,
            ),
          ]);
        }))),
  );
}

/* -------------------------------- *
 * --------------Poll-------------- *
 * -------------------------------- */

Widget shimPoll(
    {required StateSetter setState, required BuildContext context}) {
  return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 32),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                height: 76,
                width: 76,
                backgroundColor: CColors.tertiaryShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 32, 8),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 10,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 32, 8),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 10,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 128, 16),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 10,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
            Column(
                children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                child: ShimmerWidget.rectangular(
                    shapeBorder: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    height: 32,
                    backgroundColor: CColors.mainShimmerBackground,
                    shimmerColor: CColors.shimmerColor,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Container(
                            width: 12,
                            height: 12,
                            decoration: const ShapeDecoration(
                                color: CColors.secondaryShimmerBackground,
                                shape: CircleBorder())),
                      ),
                    ]),
              ),
            )),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                height: 32,
                width: 96,
                backgroundColor: CColors.buttonShimmerBackground,
                shimmerColor: CColors.shimmerColor,
              ),
            ),
          ]));
}

/* -------------------------------- *
 * ------------Question------------ *
 * -------------------------------- */

Widget shimQuestion(
    {required StateSetter setState, required BuildContext context}) {
  return Column(
    children: [
      Expanded(child: shimPoll(setState: setState, context: context)),
      const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 8),
        child: ShimmerWidget.divider(),
      ),
      Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(32, 16 , 32, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(

                Icons.keyboard_arrow_left,
                size: 24,
                color: CColors.secondaryShimmerBackground,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(

                      children: List.generate(
                    10,
                    (index) => const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                      child: ShimmerWidget.rectangular(
                        shapeBorder: RoundedRectangleBorder(side: BorderSide(width: 2)),
                        type: ShimmerType.outlined,
                        height: 32,
                        width: 32,
                        backgroundColor: CColors.mainShimmerBackground,
                        shimmerColor: CColors.shimmerColor,
                      ),
                    ),
                  )),

                ),

              ),
              const Icon(

                Icons.keyboard_arrow_right,
                size: 24,
                color: CColors.secondaryShimmerBackground,
              ),
            ],
          ))
    ],
  );
}
