import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'blurred_bottom_sheet.dart';
import 'custom_elevated_button.dart';
import 'form_state_mixin.dart';

class AddCourseWidget extends ConsumerStatefulWidget {
  const AddCourseWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCourseWidget> createState() => _AddCourseWidgetState();
}

class _AddCourseWidgetState extends ConsumerState<AddCourseWidget>
    with TickerProviderStateMixin, FormStateMixin, ConnectionStateMixin {
  static const String code = 'access_code';

  @override
  void initState() {
    super.initState();
    requiredFields = [code];
    formValues[code] = [null, null];
  }

  void _submit() async {
    const String toyTimeZone = 'America/Belize';
    setState(() => submitted = true);
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await AddCourseCall.call(
      token: StoredPreferences.authToken,
      accessCode: formValues[code][dataIndex],
      studentID: StoredPreferences.userAccount,
      timeZone: toyTimeZone,
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      String type = getJsonField((serverRequest?.jsonBody ?? ''), r'''$.type''')
          .toString();
      if (type == 'error') {
        final errors =
            getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
        onReceivedErrorsFromServer(errors);
      } else {
        context.popRoute();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'You have successfully joined the course.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryText,
          ),
        );
      }
    } else {
      final errors =
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  void _onTextChanged(String text) {
    setState(() {
      formValues[code] = [text, null];
    });
    checkFormIsReadyToSubmit();
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/book_icon.svg',
                            width: 32,
                            height: 32,
                            color: theme.primaryColor,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 0, 0),
                            child: Text(
                              'Course Registration',
                              textAlign: TextAlign.center,
                              style: theme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: theme.primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
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
                          'Please enter the course code used given by your instructor.',
                          textAlign: TextAlign.start,
                          style: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 14,
                            color: theme.secondaryText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Form(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Course Code',
                                    prefixIcon: const Icon(
                                      Icons.mode_edit,
                                    ),
                                    floatingLabelStyle:
                                        TextStyle(color: theme.primaryColor),
                                    hintText: 'Course Code',
                                    errorText: submitted
                                        ? formValues[code][errorIndex]
                                        : null,
                                  ),
                                  style: theme.bodyText1,
                                  onChanged: _onTextChanged,
                                  enabled:
                                      formState != FormStateValue.processing,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 24, 0, 0),
                                child: CustomElevatedButton(
                                  formState: formState,
                                  normalText: 'JOIN COURSE',
                                  errorText: 'TRY IT AGAIN',
                                  processingText: 'JOINING COURSE',
                                  onPressed: _submit,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
    );
  }
}
