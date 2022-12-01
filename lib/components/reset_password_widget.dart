import 'dart:ui';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../welcome_page/welcome_page_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String emailRequired = "The email field is required.";
String emailNotFound = "We were unable to find an account with that email.";

TextEditingController? forgotPasswordEmailFieldController;
bool _submitted = false;

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget>
    with TickerProviderStateMixin {
  TextEditingController? forgotPasswordEmailFieldController;

  String? get _emailErrorText {
    final text = forgotPasswordEmailFieldController?.value.text;
    if (text != null && text.isEmpty) {
      return emailRequired;
    } else {
      return emailNotFound;
    }
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_emailErrorText == null) {
      widget.onSubmit(forgotPasswordEmailFieldController?.value.text);
    }
  }

  ApiCallResponse? forgotPassword;
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

    forgotPasswordEmailFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context); //pop back on blur
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0x0E1862B3),
          ),
          alignment: AlignmentDirectional(0, 1),
          child: InkWell(
            onTap: () async {}, //no pop back on white background
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/lock.svg',
                            width: 32,
                            height: 32,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Text(
                              'Password Recovery',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 48,
                        thickness: 1,
                        color: FlutterFlowTheme.of(context).lineColor,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Please enter the email address used for \nregistration.',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Open Sans',
                                fontSize: 14,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryText,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                        child: Container(
                          width: double.infinity,
                          child: TextField(
                            controller: forgotPasswordEmailFieldController,
                            decoration: InputDecoration(
                              labelText: 'Email*',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                              ),
                              floatingLabelStyle: TextStyle(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryColor),
                              errorText: _submitted ? _emailErrorText : null,
                              hintText: 'example@email.com',
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(36),
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          primary: FlutterFlowTheme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () async {
                          forgotPassword = await ForgotPasswordCall.call(
                            email: forgotPasswordEmailFieldController!.text,
                          );
                          if ((forgotPassword?.succeeded ?? true)) {
                            await Future.delayed(
                                const Duration(milliseconds: 3000));
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: WelcomePageWidget(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Email Sent',
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
                            _submit();
                            if (animationsMap['textOnActionTriggerAnimation'] ==
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
                        child: Text('RESET PASSWORD'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
