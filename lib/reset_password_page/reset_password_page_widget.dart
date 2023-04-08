import 'package:adapt_clicker/components/MainAppBar.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/form_state_mixin.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../utils/stored_preferences.dart';
import '../flutter_flow/flutter_flow_util.dart';

class ResetPasswordPageWidget extends ConsumerStatefulWidget {
  const ResetPasswordPageWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  ConsumerState<ResetPasswordPageWidget> createState() =>
      _ResetPasswordPageWidgetState();
}

class _ResetPasswordPageWidgetState
    extends ConsumerState<ResetPasswordPageWidget> with FormStateMixin {
  static const String currentPassword = 'current_password';
  static const String password = 'password';
  static const String passwordConfirmation = 'password_confirmation';
  final Map<String, bool> _fieldsVisibility = {
    currentPassword: false,
    password: false,
    passwordConfirmation: false
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    requiredFields = [password, passwordConfirmation];
    formValues[currentPassword] = [null, null];
    formValues[password] = [null, null];
    formValues[passwordConfirmation] = [null, null];
  }

  void _submit() async {
    if (!checkConnection()) return;
    serverRequest = await UpdatePasswordCall.call(
      token: StoredPreferences.authToken,
      password: formValues[password][dataIndex],
      passwordConfirmation: formValues[passwordConfirmation][dataIndex],
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password Updated Successfully',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryBtnText,
            ),
          ),
          duration: const Duration(milliseconds: Constants.snackBarDurationMil),
          backgroundColor: FlutterFlowTheme.of(context).success,
        ),
      );
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                                autofocus: true,
                                obscureText:
                                    !_fieldsVisibility[currentPassword]!,
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
                                      size: Constants.TFIconSize,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                onChanged: (value) {
                                  setState(() {
                                    formValues[currentPassword] = [value, null];
                                    requiredFieldsFilled =
                                        checkRequiredFieldsFilled(
                                            formValues, requiredFields);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
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
                                      size: Constants.TFIconSize,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                onChanged: (value) {
                                  setState(() {
                                    formValues[password] = [value, null];
                                    requiredFieldsFilled =
                                        checkRequiredFieldsFilled(
                                            formValues, requiredFields);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
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
                                      size: Constants.TFIconSize,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                onChanged: (value) {
                                  setState(() {
                                    formValues[passwordConfirmation] = [
                                      value,
                                      null
                                    ];
                                    requiredFieldsFilled =
                                        checkRequiredFieldsFilled(
                                            formValues, requiredFields);
                                  });
                                }),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: FlutterFlowTheme.of(context).title3,
                      surfaceTintColor:
                          FlutterFlowTheme.of(context).primaryBtnText,
                      minimumSize:
                          const Size.fromHeight(Constants.buttonHeight),
                      backgroundColor:
                          FlutterFlowTheme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: requiredFieldsFilled ? _submit : null,
                    child: const Text('CHANGE PASSWORD'),
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
