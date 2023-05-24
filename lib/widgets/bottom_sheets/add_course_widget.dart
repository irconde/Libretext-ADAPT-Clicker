import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'blurred_bottom_sheet.dart';
import '../buttons/custom_elevated_button_widget.dart';
import '../../mixins/form_state_mixin.dart';

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
    formFields = [code];
    initFormFieldsInfo();
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

  void _submit() async {
    const String toyTimeZone = 'America/Belize';
    setState(() => submitted = true);
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await AddCourseCall.call(
      token: UserStoredPreferences.authToken,
      accessCode: formValues[code][dataIndex],
      studentID: UserStoredPreferences.userAccount,
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
          const SnackBar(
            content: Text(
              'You have successfully joined the course.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            backgroundColor: CColors.secondaryText,
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
      formValues[code] = [text, null, formValues[code][focusNodeIndex]];
    });
    checkFormIsReadyToSubmit();
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
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
                    color: CColors.primaryColor,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      'Course Registration',
                      textAlign: TextAlign.center,
                      style: theme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: CColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 48,
                thickness: 1,
                color: CColors.lineColor,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Please enter the course code used given by your instructor.',
                  textAlign: TextAlign.start,
                  style: theme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14,
                    color: CColors.secondaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          autofocus: true,
                          focusNode: formValues[code][focusNodeIndex],
                          decoration: InputDecoration(
                            labelText: 'Course Code',
                            prefixIcon: const Icon(
                              Icons.mode_edit,
                            ),
                            floatingLabelStyle:
                                const TextStyle(color: CColors.primaryColor),
                            hintText: 'Course Code',
                            errorText:
                                submitted ? formValues[code][errorIndex] : null,
                          ),
                          style: theme.bodyText1,
                          onChanged: _onTextChanged,
                          enabled: formState != FormStateValue.processing,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (_) {
                            if (formState != FormStateValue.unfilled) {
                              _submit();
                            } else {
                              FocusScope.of(context).requestFocus(
                                  formValues[code][focusNodeIndex]);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
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
