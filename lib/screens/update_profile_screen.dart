import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/widgets/dropdowns/timezone_dropdown_widget.dart';
import 'package:adapt_clicker/widgets/navigation_drawer_widget.dart';
import 'package:adapt_clicker/widgets/shimmer/shim_pages.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/buttons/custom_elevated_button_widget.dart';
import '../widgets/app_bars/main_app_bar_widget.dart';
import '../mixins/form_state_mixin.dart';
import '../utils/app_theme.dart';
import '../utils/utils.dart';
import '../constants/dimens.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../backend/user_stored_preferences.dart';

@RoutePage()
class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen>
    with FormStateMixin, ConnectionStateMixin {
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String email = 'email';
  static const String studentId = 'student_id';
  static const String timeZone = 'time_zone';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Map<String, String>> _initialProfileValues;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    requiredFields = [firstName, lastName, studentId];
    formFields = [firstName, lastName, email, studentId, timeZone];
    initFormFieldsInfo();
    _initialProfileValues = _loadInitialUserInfo();


  }

  Future<Map<String, String>> _loadInitialUserInfo() async {
    Map<String, String> currentUserInfo = {};
    final userInfoRequest = await GetUserCall.call(
      token: UserStoredPreferences.authToken,
    );
    await AppState.timezoneContainer.initTimezones();
    if (userInfoRequest.succeeded) {
      currentUserInfo[firstName] =
          getJsonField(userInfoRequest.jsonBody, r'''$.first_name''')
              .toString();
      currentUserInfo[lastName] =
          getJsonField(userInfoRequest.jsonBody, r'''$.last_name''').toString();
      currentUserInfo[email] =
          getJsonField(userInfoRequest.jsonBody, r'''$.email''').toString();
      currentUserInfo[studentId] =
          getJsonField(userInfoRequest.jsonBody, r'''$.student_id''')
              .toString();
      currentUserInfo[timeZone] = AppState.timezoneContainer
          .getText(getJsonField(userInfoRequest.jsonBody, r'''$.time_zone''')
              .toString())
          .toString();
    }
    _initFormData(currentUserInfo);

    setState(() {
      isLoading = false;
    });

    return currentUserInfo;
  }

  void _initFormData(Map<String, String> inputValues) {
    setState(() {
      formValues[firstName] = [
        inputValues[firstName],
        null,
        formValues[firstName][focusNodeIndex]
      ];
      formValues[lastName] = [
        inputValues[lastName],
        null,
        formValues[lastName][focusNodeIndex]
      ];
      formValues[studentId] = [
        inputValues[studentId],
        null,
        formValues[studentId][focusNodeIndex]
      ];
      formValues[email] = [
        inputValues[email],
        null,
        formValues[email][focusNodeIndex]
      ];
      formValues[timeZone] = [
        inputValues[timeZone],
        null,
        formValues[timeZone][focusNodeIndex]
      ];
    });
    checkFormIsReadyToSubmit();
  }

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

  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await UpdateProfileCall.call(
        token: UserStoredPreferences.authToken,
        firstName: formValues[firstName][dataIndex],
        lastName: formValues[lastName][dataIndex],
        email: formValues[email][dataIndex],
        timeZone: AppState.timezoneContainer
            .getValue(formValues[timeZone][dataIndex]),
        studentId: formValues[studentId][dataIndex]);
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {});
      setState(() {
        formState = FormStateValue.success;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          formState = FormStateValue.normal;
        });
      });
    } else {
      final errors =
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  @override
  void dispose() {
    disposeFocusNodes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: MainAppBar(
            title: Strings.myProfile,
            scaffoldKey: scaffoldKey,
            setState: (VoidCallback fn) {
              setState(fn);
            }),
        backgroundColor: CColors.primaryBackground,
        drawer:
            const NavigationDrawerWidget(currentSelected: DrawerItems.profile),
        body: SafeArea(
            child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: isLoading ? shimProfile(setState: setState, context: context) : loadedPage(),
        )));
  }

  Widget loadedPage() {
    return FutureBuilder<Map<String, String>>(
        future: _initialProfileValues,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, 0),
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, Dimens.msMargin),
                              child: TextFormField(
                                autofocus: true,
                                enabled: formState != FormStateValue.processing,
                                initialValue: snapshot.data?[firstName],
                                decoration: InputDecoration(
                                  labelText: Strings.firstNameFieldMandatory,
                                  errorText: submitted
                                      ? formValues[firstName][errorIndex]
                                      : null,
                                  hintText: Strings.firstNameFieldHint,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                  ),
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
                                textInputAction: TextInputAction.next,
                                focusNode: formValues[firstName]
                                    [focusNodeIndex],
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(
                                        formValues[lastName][focusNodeIndex]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, Dimens.msMargin),
                              child: TextFormField(
                                initialValue: snapshot.data?[lastName],
                                enabled: formState != FormStateValue.processing,
                                decoration: InputDecoration(
                                  labelText: Strings.lastNameFieldMandatory,
                                  errorText: submitted
                                      ? formValues[lastName][errorIndex]
                                      : null,
                                  hintText: Strings.lastNameFieldHint,
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                  ),
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
                                  initialValue: snapshot.data?[studentId],
                                  enabled:
                                      formState != FormStateValue.processing,
                                  decoration: InputDecoration(
                                    labelText: Strings.studentIDFieldMandatory,
                                    errorText: submitted
                                        ? formValues[studentId][errorIndex]
                                        : null,
                                    hintText: Strings.studentIDFieldHint,
                                    prefixIcon: const Icon(
                                      Icons.school_outlined,
                                    ),
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
                                  textInputAction: TextInputAction.next,
                                  focusNode: formValues[studentId]
                                      [focusNodeIndex],
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context).requestFocus(
                                          formValues[timeZone]
                                              [focusNodeIndex])),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, Dimens.smMargin),
                              child: TimezoneDropdown(
                                  timezoneDropDownValue: formValues[timeZone]
                                      [dataIndex],
                                  onItemSelectedCallback: _onTimezoneSelected,
                                  focusNode: formValues[timeZone]
                                      [focusNodeIndex]),
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      Dimens.mmMargin, 0, Dimens.mmMargin, Dimens.msMargin),
                  child: CustomElevatedButton(
                    formState: formState,
                    normalText: Strings.updateProfileBtnLabel,
                    errorText: Strings.tryAgainBtnLabel,
                    successText: Strings.updateProfileBtnSuccessLabel,
                    processingText: Strings.updateProfileBtnProcessingLabel,
                    onPressed: _submit,
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}