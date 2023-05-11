import 'dart:ui';
import 'package:adapt_clicker/components/blurred_bottom_sheet.dart';
import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../welcome_page/welcome_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_elevated_button.dart';
import 'form_state_mixin.dart';

class ResetPasswordWidget extends ConsumerStatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordWidget> createState() =>
      _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends ConsumerState<ResetPasswordWidget>
    with TickerProviderStateMixin, FormStateMixin, ConnectionStateMixin {
  static const String email = 'email';

  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await ForgotPasswordCall.call(
      email: formValues[email][dataIndex],
    );
    // TODO. Replace animation with CustomRoute
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Password reset requested. Check your inbox.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryText,
        ),
      );
      await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          child: const WelcomePageWidget(),
        ),
      );
      setState(() {});
    } else {
      final errors =
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  @override
  void initState() {
    super.initState();
    requiredFields = [email];
    formValues[email] = [null, null];
  }

  @override
  Widget build(BuildContext context) {
    var theme = FlutterFlowTheme.of(context);
    return BlurredBottomSheet(
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
                            color: theme.primaryColor,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 0, 0),
                            child: Text(
                              'Password Recovery',
                              textAlign: TextAlign.center,
                              style: theme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: theme.primaryColor,
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
                        color: theme.lineColor,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Please enter the email address used for \nregistration.',
                          textAlign: TextAlign.start,
                          style: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 14,
                            color: theme.tertiaryText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
                            decoration: InputDecoration(
                              labelText: 'Email*',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: theme.primaryColor),
                              errorText: submitted
                                  ? formValues[email][errorIndex]
                                  : null,
                              hintText: 'example@email.com',
                            ),
                            style: theme.bodyText1,
                            onChanged: (value) {
                              setState(() {
                                formValues[email] = [value, null];
                              });
                              checkFormIsReadyToSubmit();
                            },
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                        formState: formState,
                        normalText: 'RESET PASSWORD',
                        errorText: 'TRY IT AGAIN',
                        processingText: 'RESETTING PASSWORD',
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
