import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/widgets/bottom_sheets/reset_password_widget.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/logger.dart';
import '../../widgets/app_bars/collapsible_app_bar_widget.dart';
import '../../mixins/form_state_mixin.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';

/// Screen that provides the user with a form to sign in
@RoutePage()
class LoginScreenWidget extends ConsumerStatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreenWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreenWidget>
    with FormStateMixin, ConnectionStateMixin {

  //Local
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool passwordVisibility = false;

  //Forms
  static const String email = 'email';
  static const String password = 'password';
  
  @override
  void initState() {
    super.initState();
    requiredFields = [email, password];
    formFields = [email, password];
    initFormFieldsInfo();
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
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
                                  prefixIcon: IIcons.email,
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
                                    prefixIcon: IIcons.password,
                                    suffixIcon: IIcons.toggleVisIcon(
                                      visible: passwordVisibility, onTap: () => setState(
                                          () => passwordVisibility =
                                      !passwordVisibility,
                                    ),)

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
                                    height: Dimens.sMargin,
                                    width: Dimens.sMargin,
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
                                              .fromSTEB(Dimens.xsMargin + 2, 0, 0, 0),
                                          child: Text(
                                            Strings.rememberMe,
                                            style: theme.bodyText2
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: Strings.forgotPassword,
                                              style: theme
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
                                          padding: const EdgeInsets.all(Dimens.xxsMargin),
                                          child: Text(
                                            Strings.or,
                                            style: theme
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Open Sans',
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
                                  await mLaunchUrl(Strings.ssoLink);
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
                          style: theme.bodyText1,
                          children: [
                            const TextSpan(text: Strings.dontHaveAccount),
                            TextSpan(
                                text: Strings.signUp,
                                style: theme.bodyText1.override(
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


  /// Retrieves and sets the saved authentication data if "Remember Me" is enabled.
  Future<void> recoverSavedAuthData() async {
    try {
      await _rememberMeCheck();
    } catch (e) {
      logger.e(e.toString());
    }
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
      getJsonField((serverRequest?.jsonBody ?? ''), Strings.dollarPeriod + Strings.formError);
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
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }
}
