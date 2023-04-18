import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/custom_functions.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../utils/check_internet_connectivity.dart';
import '../welcome_page/welcome_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../flutter_flow/custom_functions.dart' as functions;

String emailRequired = 'The email field is required.';
String emailNotFound = 'We were unable to find an account with that email.';

TextEditingController? forgotPasswordEmailFieldController;
bool _submitted = false;

class ResetPasswordWidget extends ConsumerStatefulWidget {
  const ResetPasswordWidget({Key? key})
      : super(key: key);


  @override
  ConsumerState<ResetPasswordWidget> createState() =>
      _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends ConsumerState<ResetPasswordWidget>
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
      onSubmit(forgotPasswordEmailFieldController?.value.text);
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
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
      finalState: AnimationState(
        offset: const Offset(0, 0),
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

  bool _checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.popRoute(); //pop back on blur
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0x0E1862B3),
          ),
          alignment: const AlignmentDirectional(0, 1),
          child: InkWell(
            onTap: () async {}, //no pop back on white background
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 0, 0),
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
                      SizedBox(
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: forgotPasswordEmailFieldController,
                            decoration: InputDecoration(
                              labelText: 'Email*',
                              prefixIcon: const Icon(
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
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () async {
                          if (!_checkConnection()) return;
                          forgotPassword = await ForgotPasswordCall.call(
                            email: forgotPasswordEmailFieldController!.text,
                          );
                          // TODO. Replace animation with CustomRoute
                          if ((forgotPassword?.succeeded ?? true) &&
                              context.mounted) {
                            await Future.delayed(
                                const Duration(milliseconds: 3000));
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 300),
                                reverseDuration:
                                    const Duration(milliseconds: 300),
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
                                duration: const Duration(milliseconds: 4000),
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
                        child: const Text('RESET PASSWORD'),
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
