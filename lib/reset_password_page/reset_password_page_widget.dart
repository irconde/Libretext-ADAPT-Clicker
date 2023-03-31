import 'package:adapt_clicker/components/MainAppBar.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../utils/check_internet_connectivity.dart';
import '../utils/stored_preferences.dart';

class ResetPasswordPageWidget extends ConsumerStatefulWidget {
  const ResetPasswordPageWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  ConsumerState<ResetPasswordPageWidget> createState() =>
      _ResetPasswordPageWidgetState();
}

String passwordRequired = 'The password field is required.';
String newPasswordRequired = 'The new password field is required.';
String confirmPasswordRequired = 'The confirm password field is required.';
String matchPasswords = 'The new passwords must match';
String catchAllError = 'Something went wrong.';

class _ResetPasswordPageWidgetState
    extends ConsumerState<ResetPasswordPageWidget> {
  TextEditingController? curPasswordTFController;
  TextEditingController? newPasswordTFController;
  TextEditingController? confirmNewPWTFController;

  late bool curPasswordTFVisibility;
  late bool newPasswordTFVisibility;
  late bool confirmNewPWTFVisibility;

  bool _submitted = false;

  ApiCallResponse? updatePassword;
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    confirmNewPWTFController = TextEditingController();
    confirmNewPWTFVisibility = false;
    curPasswordTFController = TextEditingController();
    curPasswordTFVisibility = false;
    newPasswordTFController = TextEditingController();
    newPasswordTFVisibility = false;
  }

  String? get _passwordErrorText {
    final text = curPasswordTFController!.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    } else {
      return catchAllError;
    }
  }

  String? get _newPasswordErrorText {
    final text = newPasswordTFController!.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    } else if (text != confirmNewPWTFController!.value.text) {
      return matchPasswords;
    } else {
      return catchAllError;
    }
  }

  String? get _confirmNewPasswordErrorText {
    final text = confirmNewPWTFController!.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    } else if (text != newPasswordTFController!.value.text) {
      return matchPasswords;
    } else {
      return catchAllError;
    }
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_passwordErrorText == null) {
      widget.onSubmit(curPasswordTFController!.value.text);
    }
    if (_newPasswordErrorText == null) {
      widget.onSubmit(newPasswordTFController!.value.text);
    }
    if (_confirmNewPasswordErrorText == null) {
      widget.onSubmit(confirmNewPWTFController!.value.text);
    }
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextField(
                            controller: curPasswordTFController,
                            autofocus: true,
                            obscureText: !curPasswordTFVisibility,
                            decoration: InputDecoration(
                              labelText: 'Current Password',
                              errorText: _submitted ? _passwordErrorText : null,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => curPasswordTFVisibility =
                                      !curPasswordTFVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  curPasswordTFVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: Constants.TFIconSize,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextField(
                            controller: newPasswordTFController,
                            obscureText: !newPasswordTFVisibility,
                            decoration: InputDecoration(
                              labelText: 'New Password*',
                              errorText:
                                  _submitted ? _newPasswordErrorText : null,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => newPasswordTFVisibility =
                                      !newPasswordTFVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  newPasswordTFVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: Constants.TFIconSize,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextField(
                            controller: confirmNewPWTFController,
                            obscureText: !confirmNewPWTFVisibility,
                            decoration: InputDecoration(
                              labelText: 'Confirm New Password*',
                              errorText: _submitted
                                  ? _confirmNewPasswordErrorText
                                  : null,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => confirmNewPWTFVisibility =
                                      !confirmNewPWTFVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  confirmNewPWTFVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: Constants.TFIconSize,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: Constants.requiredTextSize,
                                ),
                          ),
                        ),
                      ],
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
                    onPressed: () async {
                      if (!_checkConnection()) return;
                      updatePassword = await UpdatePasswordCall.call(
                        token: StoredPreferences.authToken,
                        password: newPasswordTFController!.text,
                        passwordConfirmation: confirmNewPWTFController!.text,
                      );
                      if ((updatePassword?.succeeded ?? true) &&
                          context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Password Updated Successfully',
                              style: TextStyle(
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                            ),
                            duration: const Duration(
                                milliseconds: Constants.snackBarDurationMil),
                            backgroundColor:
                                FlutterFlowTheme.of(context).success,
                          ),
                        );
                      } else {
                        _submit();
                      }
                      setState(() {});
                    },
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
