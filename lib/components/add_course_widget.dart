import 'dart:ui';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../utils/check_internet_connectivity.dart';

class AddCourseWidget extends ConsumerStatefulWidget {
  const AddCourseWidget({Key? key}) : super(key: key);
  @override
  ConsumerState<AddCourseWidget> createState() => _AddCourseWidgetState();
}

class _AddCourseWidgetState extends ConsumerState<AddCourseWidget>
    with TickerProviderStateMixin {
  final TextEditingController _accessCodeACController = TextEditingController();
  ApiCallResponse? addCourse;
  bool _submitted = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
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

  void _submit() async {
    const String toyTimeZone = 'America/Belize';
    setState(() => _submitted = true);
    if (!_checkConnection()) return;
    addCourse = await AddCourseCall.call(
      token: StoredPreferences.authToken,
      accessCode: _accessCodeACController.text,
      studentID: StoredPreferences.userAccount,
      timeZone: toyTimeZone,
    );
    if ((addCourse?.succeeded ?? true) && context.mounted) {
      String type = getJsonField((addCourse?.jsonBody ?? ''), r'''$.type''')
          .toString();
      if (type == 'error') {
        setState(() {
          _errorText = getJsonField((addCourse?.jsonBody ?? ''), r'''$.message''')
              .toString();
        });
      } else {
        context.popRoute();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You have successfully joined the course',
              style: TextStyle(
                color: FlutterFlowTheme.of(context)
                    .primaryBtnText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor:
            FlutterFlowTheme.of(context).success,
          ),
        );
      }
    } else {
      setState(() {
        _errorText = getJsonField((addCourse?.jsonBody ?? ''), r'''$.message''')
            .toString();
      });
    }
  }

  void _onTextChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  void dispose() {
    _accessCodeACController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.popRoute();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0x0E1862B3),
          ),
          alignment: const AlignmentDirectional(0, 1),
          child: InkWell(
            onTap: () async {}, //keeps actual background not clicking
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/book_icon.svg',
                            width: 32,
                            height: 32,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 0, 0),
                            child: Text(
                              'Course Registration',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 48,
                        thickness: 1,
                        color: FlutterFlowTheme.of(context).lineColor,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Please enter the course code used given by your instructor.',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Open Sans',
                                fontSize: 14,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: _accessCodeACController,
                          builder: (context, TextEditingValue value, __) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: _accessCodeACController,
                                      decoration: InputDecoration(
                                        labelText: 'Course Code',
                                        prefixIcon: const Icon(
                                          Icons.mode_edit,
                                        ),
                                        floatingLabelStyle: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor),
                                        hintText: 'Course Code',
                                        errorText:
                                            _submitted ? _errorText : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      onChanged: _onTextChanged,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 24, 0, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(36),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        elevation: 4,
                                      ),
                                      onPressed: _accessCodeACController
                                              .value.text.isNotEmpty
                                          ? _submit
                                          : null,
                                      child: const Text('JOIN COURSE'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
