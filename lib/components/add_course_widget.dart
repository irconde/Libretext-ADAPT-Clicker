import 'dart:ui';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCourseWidget extends StatefulWidget {
  const AddCourseWidget({Key? key}) : super(key: key);

  @override
  _AddCourseWidgetState createState() => _AddCourseWidgetState();
}

class _AddCourseWidgetState extends State<AddCourseWidget>
    with TickerProviderStateMixin {
  TextEditingController? accessCodeACController;

  ApiCallResponse? addCourse;
  final animationsMap = {
    'textOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      duration: 2400,
      hideBeforeAnimating: true,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    setupTriggerAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onActionTrigger),
      this,
    );

    accessCodeACController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0x0E1862B3),
          ),
          alignment: AlignmentDirectional(0, 0),
          child: InkWell(
            onTap: () async {}, //keeps actual background not clicking
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/book_icon.svg',
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 8, 0, 0),
                          child: Text(
                            'Course Registration',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Open Sans',
                                  fontSize: 20,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Text(
                        'Please enter the course code used given by your instructor.',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: TextField(
                        controller: accessCodeACController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: "Course Code",
                          prefixIcon: Icon(
                            Icons.mode_edit,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w400,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(36, 0, 0, 16),
                      child: Text(
                        functions.getTopError(FFAppState().errorsList.toList()),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.of(context).failure,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                      ).animated(
                          [animationsMap['textOnActionTriggerAnimation']!]),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 32),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Open Sans',
                            ),
                            foregroundColor:
                                FlutterFlowTheme.of(context).primaryBtnText,
                            fixedSize: const Size(330, 36),
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () async {
                            addCourse = await AddCourseCall.call(
                              token: FFAppState().authToken,
                              accessCode: accessCodeACController!.text,
                              timeZone: 'America/Belize',
                            );
                            if ((addCourse?.succeeded ?? true)) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Password Updated Successfully',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).success,
                                ),
                              );
                            } else {
                              setState(
                                  () => FFAppState().errorsList = (getJsonField(
                                        (addCourse?.jsonBody ?? ''),
                                        r'''$.errors..*''',
                                      ) as List)
                                          .map<String>((s) => s.toString())
                                          .toList());
                              if (animationsMap[
                                      'textOnActionTriggerAnimation'] ==
                                  null) {
                                return;
                              }
                              await (animationsMap[
                                          'textOnActionTriggerAnimation']!
                                      .curvedAnimation
                                      .parent as AnimationController)
                                  .forward(from: 0.0);
                            }

                            setState(() {});
                          },
                          child: const Text("JOIN COURSE"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
