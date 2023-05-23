import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/components/main_app_bar.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/custom_elevated_button.dart';
import '../components/form_state_mixin.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import '../utils/stored_preferences.dart';
import '../flutter_flow/flutter_flow_util.dart';

@RoutePage()
class ResetPasswordPageWidget extends ConsumerStatefulWidget {
  const ResetPasswordPageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordPageWidget> createState() =>
      _ResetPasswordPageWidgetState();
}

class _ResetPasswordPageWidgetState
    extends ConsumerState<ResetPasswordPageWidget>
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

  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await UpdatePasswordCall.call(
      token: StoredPreferences.authToken,
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
          title: 'My Password',
          scaffoldKey: scaffoldKey,
          setState: (VoidCallback fn) {
            setState(fn);
          }),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: const DrawerCtnWidget(currentSelected: DrawerItems.password),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Constants.mmMargin, Constants.mmMargin, Constants.mmMargin, 0),
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
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                              autofocus: true,
                              enabled: formState != FormStateValue.processing,
                              obscureText: !_fieldsVisibility[currentPassword]!,
                              decoration: InputDecoration(
                                labelText: 'Current Password',
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
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: Constants.tfIconSize,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
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
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                              enabled: formState != FormStateValue.processing,
                              obscureText: !_fieldsVisibility[password]!,
                              decoration: InputDecoration(
                                labelText: 'New Password*',
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
                                    size: Constants.tfIconSize,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
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
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                              enabled: formState != FormStateValue.processing,
                              obscureText:
                                  !_fieldsVisibility[passwordConfirmation]!,
                              decoration: InputDecoration(
                                labelText: 'Confirm New Password*',
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
                                    size: Constants.tfIconSize,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
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
                              onFieldSubmitted: (_) => _submit(),
                            ),
                          ),
                          Align(
                            alignment: const Alignment(1, 0),
                            child: Text(
                              '*Required Fields',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: Constants.requiredTextSize,
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
                      0, 0, 0, Constants.msMargin),
                  child: CustomElevatedButton(
                    formState: formState,
                    normalText: 'CHANGE PASSWORD',
                    errorText: 'TRY IT AGAIN',
                    successText: 'PASSWORD UPDATED',
                    processingText: 'CHANGING PASSWORD',
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
