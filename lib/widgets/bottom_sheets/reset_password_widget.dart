import 'package:adapt_clicker/constants/dimens.dart';
import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/widgets/bottom_sheets/blurred_bottom_sheet.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/custom_elevated_button_widget.dart';
import '../../mixins/form_state_mixin.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';

/// A widget for resetting the user's password.
class ResetPasswordWidget extends ConsumerStatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordWidget> createState() =>
      _ResetPasswordWidgetState();
}

/// The state class for the [ResetPasswordWidget].
class _ResetPasswordWidgetState extends ConsumerState<ResetPasswordWidget>
    with TickerProviderStateMixin, FormStateMixin, ConnectionStateMixin {

  //Form
  static const String email = 'email';

  //Init
  @override
  void initState() {
    super.initState();
    requiredFields = [email];
    formFields = [email];
    initFormFieldsInfo();
  }

  //Build
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return BlurredBottomSheet(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin),
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
                    color: CColors.primaryColor,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(Dimens.xsMargin, 0, 0, 0),
                    child: Text(
                      Strings.passwordRecovery,
                      textAlign: TextAlign.center,
                      style: theme.title2.override(
                        fontFamily: 'Open Sans',
                        color: CColors.primaryColor,
                      ),
                    ),
                  ),
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
                  Strings.enterEmail,
                  textAlign: TextAlign.start,
                  style: theme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14,
                    color: CColors.tertiaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, Dimens.msMargin, 0, Dimens.msMargin),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: true,
                    focusNode: formValues[email][focusNodeIndex],
                    enabled: formState != FormStateValue.processing,
                    decoration: InputDecoration(
                      labelText: Strings.emailFieldMandatory,
                      prefixIcon: IIcons.email,
                      floatingLabelStyle:
                          const TextStyle(color: CColors.primaryColor),
                      errorText:
                          submitted ? formValues[email][errorIndex] : null,
                      hintText: Strings.emailHint,
                    ),
                    style: theme.bodyText1,
                    onChanged: _onTextChanged,
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (_) {
                      if (formState != FormStateValue.unfilled) {
                        _submit();
                      } else {
                        FocusScope.of(context)
                            .requestFocus(formValues[email][focusNodeIndex]);
                      }
                    },
                  ),
                ),
              ),
              CustomElevatedButton(
                formState: formState,
                normalText: Strings.resetPwdBtnLabel,
                errorText: Strings.tryAgainBtnLabel,
                processingText: Strings.resetPwdBtnProcessingLabel,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Callback for handling text changes in the email field.
  void _onTextChanged(String text) {
    setState(() {
      formValues[email] = [text, null, formValues[email][focusNodeIndex]];
    });
    checkFormIsReadyToSubmit();
  }

  /// Handles the form submission when the user clicks the submit button.
  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await ForgotPasswordCall.call(
      email: formValues[email][dataIndex],
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Strings.pwdRequestedMsg,
            style: AppTheme.of(context).reverseBodyText,
          ),
          backgroundColor: CColors.secondaryText,
        ),
      );
      context.popRoute();
      setState(() {});
    } else {
      final errors =
      getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  //Dispose
  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }
}
