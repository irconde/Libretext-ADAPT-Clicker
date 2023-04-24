import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/components/main_app_bar.dart';
import 'package:adapt_clicker/components/collapsing_libre_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/components/contact_us_dropdown_list.dart';
import '../components/custom_elevated_button.dart';
import '../components/drawer_ctn.dart';
import '../components/form_state_mixin.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_util.dart';

@RoutePage()
class ContactUsWidget extends ConsumerStatefulWidget {
  final bool? openFromDrawer;

  const ContactUsWidget({Key? key, this.openFromDrawer = false})
      : super(key: key);

  @override
  ConsumerState<ContactUsWidget> createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends ConsumerState<ContactUsWidget>
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
    formValues[name] = [null, null];
    formValues[email] = [null, null];
    formValues[subject] = [null, null];
    formValues[text] = [null, null];
  }

  void _onSubjectSelected(subjectValue) {
    setState(() {
      formValues[subject] = [subjectValue, null];
    });
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
            backgroundColor: FlutterFlowTheme.of(context).secondaryText,
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
          ? const DrawerCtnWidget(currentSelected: DrawerItems.contact)
          : null,
      body: widget.openFromDrawer!
          ? buildGestureDetector(context)
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  CollapsingLibreAppBar(
                    title: 'Contact Us',
                    iconPath: 'assets/images/contact_support.svg',
                    svgIconColor: FlutterFlowTheme.of(context).svgIconColor,
                  ),
                ];
              },
              body: buildGestureDetector(context),
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
                        style: FlutterFlowTheme.of(context).bodyText1.override(
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
                          decoration: InputDecoration(
                            labelText: 'Name*',
                            errorText:
                                submitted ? formValues[name][errorIndex] : null,
                            hintText: 'FirstName LastName',
                          ),
                          onChanged: (value) {
                            setState(() {
                              formValues[name] = [value, null];
                            });
                            checkFormIsReadyToSubmit();
                          }),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email*',
                            floatingLabelStyle: TextStyle(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor),
                            errorText: submitted
                                ? formValues[email][errorIndex]
                                : null,
                            hintText: 'example@email.com',
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          onChanged: (value) {
                            setState(() {
                              formValues[email] = [value, null];
                            });
                            checkFormIsReadyToSubmit();
                          }),
                    ),
                    ContactUsDropDownList(
                      contactUsSubjectDropDownValue: formValues[subject]
                          [dataIndex],
                      onItemSelected: _onSubjectSelected,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.top,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            errorText:
                                submitted ? formValues[text][errorIndex] : null,
                            hintText: 'Enter Message',
                            alignLabelWithHint: true,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 14,
                                  ),
                          maxLines: 8,
                          onChanged: (value) {
                            setState(() {
                              formValues[text] = [value, null];
                            });
                          }),
                    ),
                    Align(
                      alignment: const Alignment(1, 0),
                      child: Text(
                        '*Required Fields',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
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
