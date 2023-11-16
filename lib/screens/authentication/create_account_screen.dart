import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/mixins/form_state_mixin.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:adapt_clicker/widgets/app_bars/collapsible_app_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/widgets/dropdowns/timezone_dropdown_widget.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../widgets/buttons/custom_elevated_button_widget.dart';
import '../../utils/app_theme.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';
import '../../backend/user_stored_preferences.dart';
import '../../utils/utils.dart';

/// Screen for creating a new account.
@RoutePage()
class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen>
    with FormStateMixin, ConnectionStateMixin {

  //Local
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool passwordFieldCAVisibility = false;
  bool confirmPasswordFieldCAVisibility = false;


  //Form
  final _formKey = GlobalKey<FormState>();
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String studentId = 'student_id';
  static const String email = 'email';
  static const String password = 'password';
  static const String passwordConfirmation = 'password_confirmation';
  static const String timeZone = 'time_zone';

  //Init
  @override
  void initState() {
    super.initState();
    _loadTimeZones();
    setState(() {
      requiredFields = [
        firstName,
        lastName,
        studentId,
        email,
        password,
        passwordConfirmation,
        timeZone
      ];
      formFields = [
        firstName,
        lastName,
        studentId,
        email,
        password,
        passwordConfirmation,
        timeZone
      ];
      initFormFieldsInfo();
    });
  }


  ///Build
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: CColors.primaryBackground,
      key: scaffoldKey,
      body: CollapsibleAppBar(
        title: Strings.createAccount,
        iconPath: 'assets/images/person_add1.svg',
        svgIconColor: CColors.svgIconColor,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Dimens.msMargin),
                          child: TextFormField(
                            autofocus: true,
                            enabled: formState != FormStateValue.processing,
                            decoration: InputDecoration(
                              hintText: Strings.firstNameFieldHint,
                              labelText: Strings.firstNameField,
                              errorText: submitted
                                  ? formValues[firstName][errorIndex]
                                  : null,
                              prefixIcon: IIcons.profileName,
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[firstName] = [
                                  value,
                                  null,
                                  formValues[firstName][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: theme.bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[firstName][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[lastName][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Dimens.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
                            decoration: InputDecoration(
                              hintText: Strings.lastNameFieldHint,
                              labelText: Strings.lastNameField,
                              errorText: submitted
                                  ? formValues[lastName][errorIndex]
                                  : null,
                              prefixIcon: IIcons.profileName,
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[lastName] = [
                                  value,
                                  null,
                                  formValues[lastName][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: theme.bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[lastName][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[studentId][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Dimens.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
                            decoration: InputDecoration(
                              prefixIcon: IIcons.studentID,
                              labelText: Strings.studentIDField,
                              errorText: submitted
                                  ? formValues[studentId][errorIndex]
                                  : null,
                              hintText: Strings.studentIDFieldHint,
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[studentId] = [
                                  value,
                                  null,
                                  formValues[studentId][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: theme.bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[studentId][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[email][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Dimens.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
                            decoration: InputDecoration(
                              hintText: Strings.emailFieldHint,
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
                            style: theme.bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[email][focusNodeIndex],
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
                            obscureText: !passwordFieldCAVisibility,
                            decoration: InputDecoration(
                              hintText: Strings.passwordFieldHint,
                              labelText: Strings.passwordField,
                              errorText: submitted
                                  ? formValues[password][errorIndex]
                                  : null,
                              prefixIcon: IIcons.password,
                              suffixIcon: IIcons.toggleVisIcon(visible: passwordFieldCAVisibility, onTap: () => setState(
                                    () => passwordFieldCAVisibility =
                                !passwordFieldCAVisibility,
                              ),
                              )
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
                            style: theme.bodyText1,
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
                            obscureText: !confirmPasswordFieldCAVisibility,
                            decoration: InputDecoration(
                              hintText: Strings.passwordFieldHint,
                              labelText: Strings.confirmPasswordField,
                              errorText: submitted
                                  ? formValues[passwordConfirmation][errorIndex]
                                  : null,
                              prefixIcon: IIcons.password,
                              suffixIcon: IIcons.toggleVisIcon(visible: confirmPasswordFieldCAVisibility,  onTap: () => setState(
                                    () => confirmPasswordFieldCAVisibility =
                                !confirmPasswordFieldCAVisibility,
                              ))
                            ),
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
                            style: theme.bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[passwordConfirmation]
                                [focusNodeIndex],
                            onFieldSubmitted: (_) => _openTimezoneSelector,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Dimens.msMargin),
                          child: TimezoneDropdown(
                            timezoneDropDownValue: formValues[timeZone]
                                [dataIndex],
                            onItemSelectedCallback: _onTimezoneSelected,
                            focusNode: formValues[timeZone][focusNodeIndex],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        Dimens.mmMargin, 0, Dimens.mmMargin, Dimens.mmMargin),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Dimens.msMargin),
                          child: CustomElevatedButton(
                            formState: formState,
                            normalText: Strings.signUpBtnLabel,
                            errorText: Strings.tryAgainBtnLabel,
                            processingText: Strings.signUpBtnProcessingLabel,
                            onPressed: _submit,
                          ),
                        ),
                        Stack(
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
                                  style:
                                      theme.bodyText2.override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 20,
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, Dimens.msMargin, 0, Dimens.mmMargin),
                          child: CustomElevatedButton(
                            type: ButtonType.external,
                            normalText: Strings.campusSignUpBtnLabel,
                            onPressed: () async {
                              if (!checkConnection()) return;
                              await mLaunchUrl(Strings.ssoLink);
                                 },
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: theme.bodyText1,
                              children: [
                                const TextSpan(text: Strings.havingProblems),
                                TextSpan(
                                    text: Strings.contactus,
                                    style: theme
                                        .bodyText1
                                        .override(
                                          color: CColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'Open Sans',
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        context.pushRoute(
                                          ContactUsScreen(),
                                        );
                                      }),
                              ]),
                        ),
                      ],
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

  /// Loads the available time zones asynchronously.
  Future<void> _loadTimeZones() async {
    await AppState.timezoneContainer.initTimezones();
    setState(() {});
  }


  /// Opens the time zone selector when the user taps on the field.
  void _openTimezoneSelector() {
    FocusScope.of(context).requestFocus(formValues[timeZone][focusNodeIndex]);
  }

  /// Callback when a time zone is selected from the dropdown.
  void _onTimezoneSelected(timezone) {
    setState(() {
      formValues[timeZone] = [
        timezone,
        null,
        formValues[timeZone][focusNodeIndex]
      ];
    });
    checkFormIsReadyToSubmit();
  }

  /// Shows a snackbar with a success message after successful sign up.
  void _showSignUpSnackBar(String userAccount) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: RichText(
              text: TextSpan(
                text: Strings.accountFor,
                style: AppTheme.of(context).reverseBodyText,
                children: <TextSpan>[
                  TextSpan(
                    text: userAccount,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: Strings.successfullyCreated),
                ],
              ),
            ),
            backgroundColor: CColors.secondaryText),
      );
    });
  }

  /// Submits the form for creating a new account.
  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    final String currentEmail = formValues[email][dataIndex];
    final String currentPassword = formValues[password][dataIndex];
    final String currentStudentId = formValues[studentId][dataIndex];
    final timezoneValue =
    AppState.timezoneContainer.getValue(formValues[timeZone][dataIndex]);
    serverRequest = await CreateUserCall.call(
      email: currentEmail,
      password: currentPassword,
      passwordConfirmation: formValues[passwordConfirmation][dataIndex],
      firstName: formValues[firstName][dataIndex],
      lastName: formValues[lastName][dataIndex],
      registrationType: Strings.registrationType,
      studentId: currentStudentId,
      timeZone: timezoneValue,
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {
        UserStoredPreferences.userAccount = currentEmail;
        UserStoredPreferences.userPassword = currentPassword;
      });

      _showSignUpSnackBar(currentStudentId);

      ApiCallResponse? loginRequest = await LoginCall.call(
        email: currentEmail,
        password: currentPassword,
      );

      if ((loginRequest.succeeded) && context.mounted) {
        setState(() {
          UserStoredPreferences.authToken = createToken(getJsonField(
            (loginRequest.jsonBody ?? ''),
            Strings.dollarPeriod + Strings.formToken,
          ).toString());
        });

        FocusScope.of(context).unfocus();
        await context.pushRoute(CourseListScreen());
      } else {
        final errors =
        getJsonField((loginRequest.jsonBody ?? ''), Strings.dollarPeriod + Strings.formError);
        onReceivedErrorsFromServer(errors);
      }
    } else {
      final errors =
      getJsonField((serverRequest?.jsonBody ?? ''), Strings.dollarPeriod + Strings.formError);
      onReceivedErrorsFromServer(errors);
    }
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

}
