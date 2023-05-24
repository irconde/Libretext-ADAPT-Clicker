import 'package:adapt_clicker/widgets/bottom_sheets/blurred_bottom_sheet.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/custom_elevated_button_widget.dart';
import '../../mixins/form_state_mixin.dart';

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
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset requested. Check your inbox.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
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

  @override
  void initState() {
    super.initState();
    requiredFields = [email];
    formFields = [email];
    initFormFieldsInfo();
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

  void _onTextChanged(String text) {
    setState(() {
      formValues[email] = [text, null, formValues[email][focusNodeIndex]];
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
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      'Password Recovery',
                      textAlign: TextAlign.center,
                      style: theme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: CColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                  'Please enter the email address used for \nregistration.',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: true,
                    focusNode: formValues[email][focusNodeIndex],
                    enabled: formState != FormStateValue.processing,
                    decoration: InputDecoration(
                      labelText: 'Email*',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      floatingLabelStyle:
                          const TextStyle(color: CColors.primaryColor),
                      errorText:
                          submitted ? formValues[email][errorIndex] : null,
                      hintText: 'example@email.com',
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
