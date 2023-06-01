import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/widgets/app_bars/main_app_bar_widget.dart';
import 'package:adapt_clicker/widgets/navigation_drawer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/buttons/custom_elevated_button_widget.dart';
import '../mixins/form_state_mixin.dart';
import '../utils/app_theme.dart';
import '../constants/dimens.dart';
import 'package:flutter/material.dart';
import '../backend/user_stored_preferences.dart';
import '../utils/utils.dart';

/// Screen for setting a new password.
@RoutePage()
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

/// The state class for the ResetPasswordScreen widget.
class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen>
    with FormStateMixin, ConnectionStateMixin {
  static const String currentPassword = 'current_password';
  static const String password = 'password';
  static const String passwordConfirmation = 'password_confirmation';
  final Map<String, bool> _fieldsVisibility = {
    currentPassword: false,
    password: false,
    passwordConfirmation: false
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    requiredFields = [password, passwordConfirmation];
    formFields = [currentPassword, password, passwordConfirmation];
    initFormFieldsInfo();
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

  /// Handles the form submission.
  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await UpdatePasswordCall.call(
      token: UserStoredPreferences.authToken,
      password: formValues[password][dataIndex],
      passwordConfirmation: formValues[passwordConfirmation][dataIndex],
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {});
      setState(() {
        formState = FormStateValue.success;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          formState = FormStateValue.unfilled;
        });
        _formKey.currentState!.reset();
      });
    } else {
      final errors =
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MainAppBar(
          title: Strings.myPassword,
          scaffoldKey: scaffoldKey,
          setState: (VoidCallback fn) {
            setState(fn);
          }),
      backgroundColor: CColors.primaryBackground,
      drawer:
          const NavigationDrawerWidget(currentSelected: DrawerItems.password),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Dimens.msMargin),
                            child: TextFormField(
                              autofocus: true,
                              enabled: formState != FormStateValue.processing,
                              obscureText: !_fieldsVisibility[currentPassword]!,
                              decoration: InputDecoration(
                                labelText: Strings.currentPasswordField,
                                errorText: submitted
                                    ? formValues[currentPassword][errorIndex]
                                    : null,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => _fieldsVisibility[currentPassword] =
                                        !_fieldsVisibility[currentPassword]!,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _fieldsVisibility[currentPassword]!
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: CColors.tertiaryColor,
                                    size: Dimens.tfIconSize,
                                  ),
                                ),
                              ),
                              style: AppTheme.of(context).bodyText1,
                              onChanged: (value) {
                                setState(() {
                                  formValues[currentPassword] = [
                                    value,
                                    null,
                                    formValues[currentPassword][focusNodeIndex]
                                  ];
                                });
                                checkFormIsReadyToSubmit();
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: formValues[currentPassword]
                                  [focusNodeIndex],
                              onFieldSubmitted: (_) => FocusScope.of(context)
                                  .requestFocus(
                                      formValues[password][focusNodeIndex]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Dimens.msMargin),
                            child: TextFormField(
                              enabled: formState != FormStateValue.processing,
                              obscureText: !_fieldsVisibility[password]!,
                              decoration: InputDecoration(
                                labelText: Strings.newPasswordFieldMandatory,
                                errorText: submitted
                                    ? formValues[password][errorIndex]
                                    : null,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => _fieldsVisibility[password] =
                                        !_fieldsVisibility[password]!,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _fieldsVisibility[password]!
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: Dimens.tfIconSize,
                                  ),
                                ),
                              ),
                              style: AppTheme.of(context).bodyText1,
                              onChanged: (value) {
                                setState(() {
                                  formValues[password] = [
                                    value,
                                    null,
                                    formValues[password][focusNodeIndex]
                                  ];
                                });
                                checkFormIsReadyToSubmit();
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: formValues[password][focusNodeIndex],
                              onFieldSubmitted: (_) => FocusScope.of(context)
                                  .requestFocus(formValues[passwordConfirmation]
                                      [focusNodeIndex]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Dimens.msMargin),
                            child: TextFormField(
                              enabled: formState != FormStateValue.processing,
                              obscureText:
                                  !_fieldsVisibility[passwordConfirmation]!,
                              decoration: InputDecoration(
                                labelText:
                                    Strings.confirmPasswordFieldMandatory,
                                errorText: submitted
                                    ? formValues[passwordConfirmation]
                                        [errorIndex]
                                    : null,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => _fieldsVisibility[
                                            passwordConfirmation] =
                                        !_fieldsVisibility[
                                            passwordConfirmation]!,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _fieldsVisibility[passwordConfirmation]!
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: Dimens.tfIconSize,
                                  ),
                                ),
                              ),
                              style: AppTheme.of(context).bodyText1,
                              onChanged: (value) {
                                setState(() {
                                  formValues[passwordConfirmation] = [
                                    value,
                                    null,
                                    formValues[passwordConfirmation]
                                        [focusNodeIndex]
                                  ];
                                });
                                checkFormIsReadyToSubmit();
                              },
                              textInputAction: TextInputAction.done,
                              focusNode: formValues[passwordConfirmation]
                                  [focusNodeIndex],
                              onFieldSubmitted: (_) {
                                if (formState != FormStateValue.unfilled) {
                                  _submit();
                                } else if (formValues[passwordConfirmation]
                                        [dataIndex] ==
                                    null) {
                                  FocusScope.of(context).requestFocus(
                                      formValues[passwordConfirmation]
                                          [focusNodeIndex]);
                                }
                              },
                            ),
                          ),
                          Align(
                            alignment: const Alignment(1, 0),
                            child: Text(
                              Strings.requiredFields,
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: CColors.primaryColor,
                                    fontSize: Dimens.requiredTextSize,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0, 0, 0, Dimens.msMargin),
                  child: CustomElevatedButton(
                    formState: formState,
                    normalText: Strings.changePwdBtnLabel,
                    errorText: Strings.tryAgainBtnLabel,
                    successText: Strings.changePwdBtnSuccessLabel,
                    processingText: Strings.changePwdBtnProcessingLabel,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
