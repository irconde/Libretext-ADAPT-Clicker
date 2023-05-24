import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/widgets/app_bars/main_app_bar_widget.dart';
import 'package:adapt_clicker/widgets/app_bars/collapsible_app_bar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/widgets/dropdowns/contact_dropdown_widget.dart';
import '../widgets/buttons/custom_elevated_button_widget.dart';
import '../widgets/navigation_drawer_widget.dart';
import '../mixins/form_state_mixin.dart';
import '../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

@RoutePage()
class ContactUsScreen extends ConsumerStatefulWidget {
  final bool? openFromDrawer;

  const ContactUsScreen({Key? key, this.openFromDrawer = false})
      : super(key: key);

  @override
  ConsumerState<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends ConsumerState<ContactUsScreen>
    with FormStateMixin, ConnectionStateMixin {
  static const String name = 'name';
  static const String email = 'email';
  static const String subject = 'subject';
  static const String text = 'text';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    requiredFields = [name, email];
    formFields = [name, email, subject, text];
    initFormFieldsInfo();
  }

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
    serverRequest = await ContactUsCall.call(
      email: formValues[email][dataIndex],
      name: formValues[name][dataIndex],
      subject: formValues[subject][dataIndex],
      text: formValues[text][dataIndex],
      school: 'unknown',
      toUserId: '0',
      type: 'contact_us',
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      if (widget.openFromDrawer == false) {
        setState(() {});
        context.popRoute();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              serverRequest!.jsonBody['message'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            backgroundColor: AppTheme.of(context).secondaryText,
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
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: widget.openFromDrawer!
          ? MainAppBar(
              title: 'Contact Us',
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
              title: 'Contact Us',
              iconPath: 'assets/images/contact_support.svg',
              svgIconColor: AppTheme.of(context).svgIconColor,
              child: buildGestureDetector(context),
            ),
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                      child: Text(
                        'Please use this form to contact us regarding general questions or issues.',
                        style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            lineHeight: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: TextFormField(
                        autofocus: true,
                        enabled: formState != FormStateValue.processing,
                        decoration: InputDecoration(
                          labelText: 'Name*',
                          errorText:
                              submitted ? formValues[name][errorIndex] : null,
                          hintText: 'FirstName LastName',
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
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: TextFormField(
                        enabled: formState != FormStateValue.processing,
                        decoration: InputDecoration(
                          labelText: 'Email*',
                          floatingLabelStyle: TextStyle(
                              color: AppTheme.of(context).primaryColor),
                          errorText:
                              submitted ? formValues[email][errorIndex] : null,
                          hintText: 'example@email.com',
                        ),
                        style: AppTheme.of(context).bodyText1,
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
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        enabled: formState != FormStateValue.processing,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          errorText:
                              submitted ? formValues[text][errorIndex] : null,
                          hintText: 'Enter Message',
                          alignLabelWithHint: true,
                        ),
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                            ),
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
                        '*Required Fields',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: AppTheme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                      child: CustomElevatedButton(
                        formState: formState,
                        normalText: 'SEND MESSAGE',
                        errorText: 'TRY IT AGAIN',
                        successText: 'MESSAGE SENT',
                        processingText: 'SENDING MESSAGE',
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
}
