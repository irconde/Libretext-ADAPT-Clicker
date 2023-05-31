import 'package:auto_route/auto_route.dart';
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
                shimmerColor: CColors.buttonShimmerEffect,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 156, 24),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1))),
                height: 12,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.secondaryShimmerEffect,
              ),
            ),
            ShimmerWidget.rectangular(
              height: 1,
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
      padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 32),
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
                shimmerColor: CColors.tertiaryShimmerEffect,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 32, 8),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 10,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.secondaryShimmerEffect,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 32, 8),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 10,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.secondaryShimmerEffect,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 128, 16),
              child: ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 10,
                backgroundColor: CColors.secondaryShimmerBackground,
                shimmerColor: CColors.secondaryShimmerEffect,
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
                shimmerColor: CColors.buttonShimmerEffect,
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
          padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
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
                        shapeBorder:
                            RoundedRectangleBorder(side: BorderSide(width: 2)),
                        type: ShimmerType.outlined,
                        height: 32,
                        width: 32,
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

/* -------------------------------- *
 * -----------Questions------------ *
 * -------------------------------- */

Widget shimQuestionList(
    {required StateSetter setState, required BuildContext context}) {
  int gridViewCrossAxisCount = 3;

  return Scaffold(
      backgroundColor: CColors.primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CColors.primaryBackground,
        elevation: .3,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: CColors.tertiaryColor,
          ),
          onPressed: () {
            context.popRoute();
          },
        ),
        title: const ShimmerWidget.rectangular(
          shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          height: 18,
          width: 128,
          backgroundColor: CColors.buttonShimmerBackground,
          shimmerColor: CColors.buttonShimmerEffect,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: CColors.buttonShimmerBackground,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: CColors.mainShimmerBackground,
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  ShimmerWidget.rectangular(
                    height: 28,
                    width: 88,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    backgroundColor: CColors.secondaryShimmerBackground,
                    shimmerColor: CColors.secondaryShimmerEffect,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ShimmerWidget.rectangular(
                      height: 28,
                      width: 128,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      backgroundColor: CColors.secondaryShimmerBackground,
                      shimmerColor: CColors.secondaryShimmerEffect,
                    ),
                  ),
                  ShimmerWidget.rectangular(
                    height: 28,
                    width: 88,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    backgroundColor: CColors.secondaryShimmerBackground,
                    shimmerColor: CColors.secondaryShimmerEffect,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.smMargin),
            child: Container(
              color: Colors.black12,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridViewCrossAxisCount,
                    childAspectRatio: 1,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                clipBehavior: Clip.none,
                itemBuilder: (context, questionsIndex) {
                  return Container(
                    color: CColors.primaryBackground,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShimmerWidget.rectangular(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          height: 40,
                          width: 28,
                          backgroundColor: CColors.buttonShimmerBackground,
                          shimmerColor: CColors.buttonShimmerEffect,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShimmerWidget.circular(
                                height: 16,
                                width: 16,
                                backgroundColor:
                                    CColors.shimmerSuccessBackground,
                                shimmerColor: CColors.shimmerSuccessEffect,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: ShimmerWidget.rectangular(
                                  shapeBorder: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                  height: 12,
                                  width: 40,
                                  backgroundColor:
                                      CColors.shimmerSuccessBackground,
                                  shimmerColor: CColors.shimmerSuccessEffect,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ShimmerWidget.rectangular(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          height: 12,
                          width: 80,
                          backgroundColor: CColors.secondaryShimmerBackground,
                          shimmerColor: CColors.secondaryShimmerEffect,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ));
}

/* -------------------------------- *
 * ----------Assignment------------ *
 * -------------------------------- */

Widget shimAssignment(
    {required StateSetter setState, required BuildContext context}) {
  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangular(
            height: Dimens.appBarHeight + 72,
            backgroundColor: CColors.primaryColor,
            shimmerColor: CColors.shimmerPrimaryEffect,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 0, 12),
                    child: Container(
                      width: 256,
                      height: 24,
                      decoration: const ShapeDecoration(
                        color: CColors.titleShimmerBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 0, 12),
                    child: Container(
                      width: 320,
                      height: 24,
                      decoration: const ShapeDecoration(
                        color: CColors.titleShimmerBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(64, 24, 32, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 56,
                          height: 12,
                          decoration: const ShapeDecoration(
                            color: CColors.titleShimmerBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(96, 0, 0, 0),
                          child: Container(
                            width: 128,
                            height: 12,
                            decoration: const ShapeDecoration(
                              color: CColors.titleShimmerBackground,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 2,
                    color: CColors.primaryBackground,
                  )
                ],
              )
            ],
          ),
          ShimmerWidget.rectangular(
            height: 128,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: Container(
                        width: 96,
                        height: 16,
                        decoration: const ShapeDecoration(
                          color: CColors.secondaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                      ),
                    ),
                    Container(
                      width: 96,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: CColors.secondaryShimmerBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 24, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: Container(
                        width: 156,
                        height: 16,
                        decoration: const ShapeDecoration(
                          color: CColors.secondaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Container(
                        width: 156,
                        height: 16,
                        decoration: const ShapeDecoration(
                          color: CColors.secondaryShimmerBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                      ),
                    ),
                    Container(
                      width: 96,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: CColors.secondaryShimmerBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 48,
                  color: CColors.secondaryColor,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(32.0),
            child: ShimmerWidget.rectangular(
              height: 12,
              width: 128,
              backgroundColor: CColors.secondaryShimmerBackground,
              shimmerColor: CColors.secondaryShimmerEffect,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                    6,
                    (index) => Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              32, 0, 23, 8),
                          child: ShimmerWidget.rectangular(
                            height: 88,
                            backgroundColor: CColors.buttonShimmerBackground,
                            shimmerColor: CColors.buttonShimmerEffect,
                            children: [
                              Container(
                                width: 4,
                                height: 88,
                                decoration: const ShapeDecoration(
                                  color: CColors.titleShimmerBackground,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 20, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 12, 0),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: const ShapeDecoration(
                                              color: CColors.detailsDarkerBlue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(2))),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 16,
                                          width: 156,
                                          decoration: const ShapeDecoration(
                                            color: CColors.detailsDarkerBlue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 16, 0, 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 8, 0),
                                            child: Container(
                                              width: 80,
                                              height: 16,
                                              decoration: const ShapeDecoration(
                                                color:
                                                    CColors.detailsLighterBlue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2))),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 16,
                                            width: 156,
                                            decoration: const ShapeDecoration(
                                              color: CColors.detailsLighterBlue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(2))),
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
                                  color: CColors.detailsDarkerBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            ),
          )
        ],
      ),
      Align(
          alignment: const Alignment(-0.98, -0.925),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: CColors.primaryBackground,
              size: 24,
            ),
            onPressed: () {
              context.popRoute();
            },
          )),
      Align(
          alignment: const Alignment(1, -0.925),
          child: IconButton(
            icon: const Icon(
              Icons.notifications,
              color: CColors.primaryBackground,
              size: 24,
            ),
            onPressed: () {
              context.popRoute();
            },
          )),
    ],
  );
}
