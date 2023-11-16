import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'blurred_bottom_sheet.dart';

import '../buttons/custom_elevated_button_widget.dart';
import '../../mixins/form_state_mixin.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';

/// Widget for adding a course.
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
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return BlurredBottomSheet(
      centered: true,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(Dimens.xsMargin, 0, 0, 0),
                    child: Text(
                      Strings.courseRegistration,
                      textAlign: TextAlign.center,
                      style: theme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: CColors.primaryColor,
                        fontSize: Dimens.msMargin,
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
                  Strings.enterCourseCodeMsg,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, Dimens.msMargin, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          autofocus: true,
                          focusNode: formValues[code][focusNodeIndex],
                          decoration: InputDecoration(
                            labelText: Strings.courseCode,
                            prefixIcon: const Icon(
                              Icons.mode_edit,
                            ),
                            floatingLabelStyle:
                                const TextStyle(color: CColors.primaryColor),
                            hintText: Strings.courseCode,
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
                            const EdgeInsetsDirectional.fromSTEB(0, Dimens.msMargin, 0, 0),
                        child: CustomElevatedButton(
                          formState: formState,
                          normalText: Strings.joinCourseBtnLabel,
                          errorText: Strings.tryAgainBtnLabel,
                          processingText: Strings.joinCourseBtnProcessingLabel,
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

  /// Submits the form to join a course.
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
          SnackBar(
            content: Text(
              Strings.joinedCourse,
              style: AppTheme.of(context).reverseBodyText,
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

  /// Callback function called when the text in the text field changes.
  void _onTextChanged(String text) {
    setState(() {
      formValues[code] = [text, null, formValues[code][focusNodeIndex]];
    });
    checkFormIsReadyToSubmit();
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

}
