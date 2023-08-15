import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/widgets/bottom_sheets/reset_password_widget.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../utils/Logger.dart';
import '../widgets/app_bars/collapsible_app_bar_widget.dart';
import '../mixins/form_state_mixin.dart';
import '../utils/app_theme.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import '../constants/dimens.dart';

/// Screen that provides the user with a form to sign in
@RoutePage()
class LoginScreenWidget extends ConsumerStatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreenWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreenWidget>
    with FormStateMixin, ConnectionStateMixin {
  static const String email = 'email';
  static const String password = 'password';
  bool passwordVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
    requiredFields = [email, password];
    formFields = [email, password];
    initFormFieldsInfo();
  }

  /// Retrieves and sets the saved authentication data if "Remember Me" is enabled.
  Future<void> recoverSavedAuthData() async {
    try {
      await _rememberMeCheck();
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

  /// Checks if "Remember Me" is enabled and populates the form fields with saved data.
  Future<void> _rememberMeCheck() async {
    String userAccount = UserStoredPreferences.userAccount;
    String userPassword = UserStoredPreferences.userPassword;
    if (UserStoredPreferences.rememberMe) {
      if (userAccount.isNotEmpty && userPassword.isNotEmpty) {
        setState(() {
          formValues[email] = [
            userAccount,
            null,
            formValues[email][focusNodeIndex]
          ];
          formValues[password] = [
            userPassword,
            null,
            formValues[password][focusNodeIndex]
          ];
        });
        checkFormIsReadyToSubmit();
      }
    }
  }

  /// Handles the login form submission.
  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await LoginCall.call(
      email: formValues[email][dataIndex],
      password: formValues[password][dataIndex],
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {
        UserStoredPreferences.authToken = createToken(getJsonField(
          (serverRequest?.jsonBody ?? ''),
          r'''$.token''',
        ).toString());
        UserStoredPreferences.userAccount = formValues[email][dataIndex];
        UserStoredPreferences.userPassword = formValues[password][dataIndex];
      });
      FocusScope.of(context).unfocus();
      await context.pushRoute(CourseListScreen());
    } else {
      final errors =
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  /// Handles the "Forgot Password" button tap.
  void _onForgotPasswordTapped() async {
    FocusScope.of(context).unfocus();
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const ResetPasswordWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primaryBackground,
      key: scaffoldKey,
      body: CollapsibleAppBar(
        title: Strings.welcomeBack,
        iconPath: 'assets/images/hand_wave.svg',
        svgIconColor: CColors.svgIconColor2,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                      future: _rememberMeCheck(),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(Dimens.mmMargin),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextFormField(
                                autofocus: true,
                                enabled: formState != FormStateValue.processing,
                                initialValue: formValues[email][dataIndex],
                                decoration: InputDecoration(
                                  labelText: Strings.emailField,
                                  errorText: submitted
                                      ? formValues[email][errorIndex]
                                      : null,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 16,
                                    ),
                                onChanged: (value) {
                                  setState(() {
                                    formValues[email] = [
                                      value,
                                      null,
                                      formValues[email][focusNodeIndex]
                                    ];
                                  });
                                  checkFormIsReadyToSubmit();
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: formValues[email][focusNodeIndex],
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(
                                        formValues[password][focusNodeIndex]),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, Dimens.msMargin, 0, Dimens.msMargin),
                                child: TextFormField(
                                  enabled:
                                      formState != FormStateValue.processing,
                                  initialValue: formValues[password][dataIndex],
                                  obscureText: !passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: Strings.passwordField,
                                    errorText: submitted
                                        ? formValues[password][errorIndex]
                                        : null,
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                    ),
                                    suffixIcon: Semantics(
                                      label: passwordVisibility
                                          ? Strings
                                              .passwordToggleShowingSemanticsLabel
                                          : Strings
                                              .passwordToggleNotShowingSemanticsLabel,
                                      child: InkWell(
                                        onTap: () => setState(
                                          () => passwordVisibility =
                                              !passwordVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: CColors.secondaryColor,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16,
                                          ),
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
                                  textInputAction: TextInputAction.done,
                                  focusNode: formValues[password]
                                      [focusNodeIndex],
                                  onFieldSubmitted: (_) {
                                    if (formState != FormStateValue.unfilled) {
                                      _submit();
                                    } else if (formValues[password]
                                            [dataIndex] ==
                                        null) {
                                      FocusScope.of(context).requestFocus(
                                          formValues[password][focusNodeIndex]);
                                    }
                                  },
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 18.0,
                                    width: 18.0,
                                    child: Semantics(
                                      label: Strings.rememberMeSemanticsLabel,
                                      child: Checkbox(
                                        onChanged: (bool? value) {
                                          setState(() =>
                                              UserStoredPreferences.rememberMe =
                                                  !UserStoredPreferences
                                                      .rememberMe);
                                        },
                                        value: UserStoredPreferences.rememberMe,
                                        activeColor: CColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 0, 0),
                                          child: Text(
                                            Strings.rememberMe,
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: CColors.secondaryText,
                                                ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: Strings.forgotPassword,
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    color: CColors.primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap =
                                                    _onForgotPasswordTapped),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, Dimens.msMargin, 0, 0),
                                child: CustomElevatedButton(
                                  formState: formState,
                                  normalText: Strings.signInBtnLabel,
                                  errorText: Strings.tryAgainBtnLabel,
                                  processingText:
                                      Strings.signInBtnProcessingLabel,
                                  onPressed: _submit,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, Dimens.msMargin, 0, Dimens.msMargin),
                                child: ExcludeSemantics(
                                  child: Stack(
                                    alignment: const AlignmentDirectional(0, 0),
                                    children: [
                                      const Divider(
                                        height: 0,
                                        thickness: 1,
                                        color: CColors.lineColor,
                                      ),
                                      Container(
                                        color: CColors.primaryBackground,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            Strings.or,
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: CColors.secondaryText,
                                                  fontSize: 20,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomElevatedButton(
                                type: ButtonType.external,
                                normalText: Strings.campusLoginBtnLabel,
                                onPressed: () async {
                                  if (!checkConnection()) return;
                                  await mLaunchUrl(
                                      'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, Dimens.llMargin, 0, Dimens.mmMargin),
                    child: RichText(
                      text: TextSpan(
                          style: AppTheme.of(context).bodyText1,
                          children: [
                            const TextSpan(text: Strings.dontHaveAccount),
                            TextSpan(
                                text: Strings.signUp,
                                style: AppTheme.of(context).bodyText1.override(
                                      color: CColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    context.pushRoute(
                                      const CreateAccountScreen(),
                                    );
                                  }),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
