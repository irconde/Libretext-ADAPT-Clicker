import 'package:adapt_clicker/components/question_c_t_n_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../utils/check_internet_connectivity.dart';
import '../utils/constants.dart';

class AssignmentGridWidget extends StatefulWidget {
  const AssignmentGridWidget({Key? key, this.questionsItem, required this.assignmentSummary, required this.ref, this.builderResponse, required this.questionsIndex}) : super(key: key);

  final dynamic questionsItem;
  final dynamic builderResponse;
  final Map<String, dynamic> assignmentSummary;
  final WidgetRef ref;
  final int questionsIndex;

  @override
  State<AssignmentGridWidget> createState() => AssignmentGridWidgetState(questionsItem, assignmentSummary, ref, builderResponse, questionsIndex);
}



class AssignmentGridWidgetState extends State<AssignmentGridWidget> {

  AssignmentGridWidgetState(this.questionsItem, this.assignmentSummary, this.ref, this.builderResponse, this.questionsIndex);
  dynamic questionsItem;
  Map<String, dynamic> assignmentSummary;
  WidgetRef ref;
  dynamic builderResponse;
  int questionsIndex;

  bool _checkConnection() {
    ConnectivityStatus? status =
    ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  // Define a function that takes a date string and returns a formatted string
  String formatDate(String date) {

    if(date == 'N/A') {
      return '';
    }
    // Parse the date string using the given format
    DateTime parsedDate = DateFormat('MMM dd, yyyy HH:mm:ss').parse(date);
    // Format the date using the desired format
    String formattedDate = DateFormat('MMMM d').format(parsedDate);
    // Return the formatted date
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var theme = FlutterFlowTheme.of(context);
    return Container(
      color: theme.primaryBackground,
      child: InkWell(

        onTap: () async {
          if (!_checkConnection()) return;
          setState(() => AppState().view =
              builderResponse
                  .jsonBody);
          setState(() => AppState()
              .question = questionsItem);
          setState(() =>
          AppState().isBasic =
              functions.isBasic(
                  getJsonField(
                    questionsItem,
                    r'''$.technology_iframe''',
                  ).toString()));
          setState(() =>
          AppState().hasSubmission =
              getJsonField(
                questionsItem,
                r'''$.has_at_least_one_submission''',
              ));
          await showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            backgroundColor:
            FlutterFlowTheme.of(
                context)
                .primaryBackground,
            context: context,
            builder: (context) {
              return Padding(
                padding:
                MediaQuery.of(context)
                    .viewInsets,
                child: SizedBox(
                  height: double.infinity,
                  child:
                  QuestionCTNWidget(
                    assignmentName:
                    assignmentSummary[
                    'name'],
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, Constants.xxsMargin, 0,0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                functions
                    .addOne(
                    questionsIndex)
                    .toString(),
                textAlign:
                TextAlign.center,
                style:
                FlutterFlowTheme.of(
                    context)
                    .bodyText1
                    .override(
                  fontSize: 48,
                  fontFamily:
                  'Open Sans',
                  fontWeight:
                  FontWeight
                      .bold,
                  color: FlutterFlowTheme.of(
                      context)
                      .primaryColor,
                ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] != 'N/A',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: theme.success,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(Constants.xxsMargin, 0, 0, Constants.xxsMargin),
                      child: Text(
                          formatDate(questionsItem['last_submitted']),
                          textAlign:
                          TextAlign.center,
                          style:
                          FlutterFlowTheme.of(
                              context)
                              .bodyText1
                              .override(
                            fontFamily:
                            'Open Sans',
                            fontWeight:
                            FontWeight.normal,
                            color: theme.success,
                          ),

                        ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] != 'N/A',
                child: Text(
                    '${questionsItem['total_score'] ?? 'Max'}/${questionsItem['points']} Points' ?? 'points/total',
                    textAlign:
                    TextAlign.center,
                    style:
                    FlutterFlowTheme.of(
                        context)
                        .bodyText3
                        .override(
                      fontFamily:
                      'Open Sans',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] == 'N/A',
                child: Text(
                  'Max ${questionsItem['points']} Points' ?? 'points/total',
                  textAlign:
                  TextAlign.center,
                  style:
                  FlutterFlowTheme.of(
                      context)
                      .bodyText3
                      .override(
                    fontFamily:
                    'Open Sans',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}