import 'package:adapt_clicker/constants/dimens.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/widgets/app_bars/main_app_bar_widget.dart';
import 'package:adapt_clicker/widgets/app_bars/collapsible_app_bar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/widgets/dropdowns/contact_dropdown_widget.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../widgets/buttons/custom_elevated_button_widget.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../mixins/form_state_mixin.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

/// Screen for letting the user contact the Libretexts team.
@RoutePage()
class ContactUsScreen extends ConsumerStatefulWidget {
  final bool? openFromDrawer;

  /// Constructs a [ContactUsScreen] widget.
  ///
  /// [openFromDrawer] indicates whether the screen is opened from the drawer menu.
  const ContactUsScreen({Key? key, this.openFromDrawer = false})
      : super(key: key);

  @override
  ConsumerState<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends ConsumerState<ContactUsScreen>
    with FormStateMixin, ConnectionStateMixin {

  //local
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String name = 'name';
  static const String email = 'email';
  static const String subject = 'subject';
  static const String text = 'text';


  @override
  void initState() {
    super.initState();
    requiredFields = [name, email];
    formFields = [name, email, subject, text];
    initFormFieldsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: widget.openFromDrawer!
          ? MainAppBar(
              title: Strings.contactUs,
              scaffoldKey: scaffoldKey,
              setState: (VoidCallback fn) {
                setState(fn);
              })
          : null,
      drawer: widget.openFromDrawer!
          ? const NavigationDrawerWidget(currentSelected: DrawerItems.contact)
          : null,
      body: widget.openFromDrawer!
          ? buildGestureDetector(context)
          : CollapsibleAppBar(
              title: Strings.contactUs,
              iconPath: 'assets/images/contact_support.svg',
              svgIconColor: CColors.svgIconColor,
              child: buildGestureDetector(context),
            ),
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    var theme = AppTheme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, Dimens.mmMargin, Dimens.mmMargin, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.mmMargin),
                      child: Text(
                        Strings.contactInfoMsg,
                        style: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            lineHeight: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.msMargin),
                      child: TextFormField(
                        autofocus: true,
                        enabled: formState != FormStateValue.processing,
                        decoration: InputDecoration(
                          labelText: Strings.nameFieldMandatory,
                          errorText:
                              submitted ? formValues[name][errorIndex] : null,
                          hintText: Strings.nameFieldHint,
                        ),
                        onChanged: (value) {
                          setState(() {
                            formValues[name] = [
                              value,
                              null,
                              formValues[name][focusNodeIndex]
                            ];
                          });
                          checkFormIsReadyToSubmit();
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: formValues[name][focusNodeIndex],
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(formValues[email][focusNodeIndex]),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.msMargin),
                      child: TextFormField(
                        enabled: formState != FormStateValue.processing,
                        decoration: InputDecoration(
                          labelText: Strings.emailFieldMandatory,
                          floatingLabelStyle:
                              const TextStyle(color: CColors.primaryColor),
                          errorText:
                              submitted ? formValues[email][errorIndex] : null,
                          hintText: Strings.emailFieldHint,
                        ),
                        style: theme.bodyText1,
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
                            .requestFocus(formValues[subject][focusNodeIndex]),
                      ),
                    ),
                    ContactDropdown(
                        contactUsSubjectDropDownValue: formValues[subject]
                            [dataIndex],
                        onItemSelected: _onSubjectSelected,
                        focusNode: formValues[subject][focusNodeIndex]),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.sMargin),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        enabled: formState != FormStateValue.processing,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: Strings.messageField,
                          errorText:
                              submitted ? formValues[text][errorIndex] : null,
                          hintText: Strings.messageFieldHint,
                          alignLabelWithHint: true,
                        ),
                        style: theme.bodyText1,
                        maxLines: 8,
                        onChanged: (value) {
                          setState(() {
                            formValues[text] = [
                              value,
                              null,
                              formValues[text][focusNodeIndex]
                            ];
                          });
                        },
                        textInputAction: TextInputAction.send,
                        focusNode: formValues[text][focusNodeIndex],
                        onFieldSubmitted: (_) {
                          if (formState != FormStateValue.unfilled) {
                            _submit();
                          } else if (formValues[text][dataIndex] == null) {
                            FocusScope.of(context)
                                .requestFocus(formValues[text][focusNodeIndex]);
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1, 0),
                      child: Text(
                        Strings.requiredFields,
                        style: theme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: CColors.primaryColor,
                              fontSize: Dimens.requiredTextSize,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, Dimens.smMargin, 0, Dimens.msMargin),
                      child: CustomElevatedButton(
                        formState: formState,
                        normalText: Strings.contactBtnLabel,
                        errorText: Strings.tryAgainBtnLabel,
                        successText: Strings.contactBtnSuccessLabel,
                        processingText: Strings.contactBtnProcessingLabel,
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Callback when a subject is selected from the dropdown.
  void _onSubjectSelected(subjectValue) {
    setState(() {
      formValues[subject] = [
        subjectValue,
        null,
        formValues[subject][focusNodeIndex]
      ];
    });
    if (formValues[text][dataIndex] == null) {
      FocusScope.of(context).requestFocus(formValues[text][focusNodeIndex]);
    }
  }

  /// Submits the contact form.
  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await ContactUsCall.call(
      email: formValues[email][dataIndex],
      name: formValues[name][dataIndex],
      subject: formValues[subject][dataIndex],
      text: formValues[text][dataIndex],
      school: Strings.schoolVal,
      toUserId: Strings.toUserIdVal,
      type: Strings.typeVal,
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      if (widget.openFromDrawer == false) {
        setState(() {});
        context.popRoute();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              serverRequest!.jsonBody['message'],
              style: AppTheme.of(context).reverseBodyText
            ),
            backgroundColor: CColors.secondaryText,
          ),
        );
      } else {
        setState(() {
          formState = FormStateValue.success;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            formState = FormStateValue.unfilled;
            _formKey.currentState!.reset();
          });
        });
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
