import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/screens/question_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/utils.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class AssignmentGridWidget extends ConsumerStatefulWidget {
  const AssignmentGridWidget(
      {Key? key,
      this.questionsItem,
      required this.assignmentSummary,
      required this.ref,
      this.builderResponse,
      required this.questionsIndex})
      : super(key: key);

  final dynamic questionsItem;
  final dynamic builderResponse;
  final Map<String, dynamic> assignmentSummary;
  final WidgetRef ref;
  final int questionsIndex;

  @override
  ConsumerState<AssignmentGridWidget> createState() =>
      AssignmentGridWidgetState();
}

class AssignmentGridWidgetState extends ConsumerState<AssignmentGridWidget>
    with ConnectionStateMixin {
  dynamic questionsItem;
  late Map<String, dynamic> assignmentSummary;
  late WidgetRef ref;
  dynamic builderResponse;
  late int questionsIndex;

  @override
  void initState() {
    super.initState();
    questionsItem = widget.questionsItem;
    assignmentSummary = widget.assignmentSummary;
    ref = widget.ref;
    builderResponse = widget.builderResponse;
    questionsIndex = widget.questionsIndex;
  }

  // Define a function that takes a date string and returns a formatted string
  String formatDate(String date) {
    if (date == 'N/A') {
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
    var theme = AppTheme.of(context);
    return Container(
      color: theme.primaryBackground,
      child: InkWell(
        onTap: () async {
          if (!checkConnection()) return;
          setState(() => AppState().view = builderResponse.jsonBody);
          setState(() => AppState().question = questionsItem);
          setState(() => AppState().isBasic = isBasic(getJsonField(
                questionsItem,
                r'''$.technology_iframe''',
              ).toString()));
          setState(() => AppState().hasSubmission = getJsonField(
                questionsItem,
                r'''$.has_at_least_one_submission''',
              ));
          await showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            backgroundColor: AppTheme.of(context).primaryBackground,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return Padding(
                      padding: MediaQuery
                          .of(context)
                          .viewInsets,
                      child: SizedBox(
                        height: double.infinity,
                        child: QuestionScreen(
                          assignmentName: assignmentSummary['name'],
                          index: questionsIndex,
                          view: builderResponse.jsonBody,
                        ),
                      ),
                    );
                  }
              );
            }
            );
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              0, Constants.xxsMargin, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                addOne(questionsIndex).toString(),
                textAlign: TextAlign.center,
                style: AppTheme.of(context).bodyText1.override(
                      fontSize: 48,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      color: AppTheme.of(context).primaryColor,
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
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Constants.xxsMargin, 0, 0, Constants.xxsMargin),
                      child: Text(
                        formatDate(questionsItem['last_submitted']),
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
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
                  '${questionsItem['total_score'] ?? 'Max'}/${questionsItem['points']} Points' ??
                      'points/total',
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).bodyText3.override(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] == 'N/A',
                child: Text(
                  'Max ${questionsItem['points']} Points' ?? 'points/total',
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).bodyText3.override(
                        fontFamily: 'Open Sans',
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
