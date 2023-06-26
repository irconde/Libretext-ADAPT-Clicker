import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/screens/question_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/strings.dart';
import '../../utils/Logger.dart';
import '../../utils/utils.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';
import '../../constants/colors.dart';

class AssignmentGridWidget extends ConsumerStatefulWidget {
  /// A widget representing a grid item in the assignment grid.
  ///
  /// The [questionsItem] represents the question item for the assignment.
  /// The [builderResponse] represents the builder response for the assignment.
  /// The [assignmentSummary] represents the summary of the assignment.
  /// The [ref] represents the widget reference.
  /// The [questionsIndex] represents the index of the question.
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
    if (questionsItem['submission_file_exists'] == true) {
      logger.w('Question $questionsIndex: ${questionsItem['date_submitted']}');
    }
  }

  /// Formats the given [date] string into a formatted date string.
  ///
  /// If the [date] is 'N/A', an empty string is returned.
  /// Otherwise, the [date] string is parsed using the format 'MMM dd, yyyy HH:mm:ss',
  /// and the formatted date string is returned using the format 'MMMM d'.
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

  String? formatDateTwo(String date) {
    if (date == 'N/A' || date == null) {
      return null;
    }
    logger.i('Passed in date: $date');

    // Parse the date string using the given format
    DateTime parsedDate = DateFormat('MMM dd, yyyy HH:mm').parse(date);

    logger.i('Parsed date $parsedDate');
    // Format the date using the desired format
    String formattedDate = DateFormat('MMMM d').format(parsedDate);
    // Return the formatted date
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColors.primaryBackground,
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
              backgroundColor: CColors.primaryBackground,
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (context, StateSetter setState) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: QuestionScreen(
                      assignmentName: assignmentSummary['name'],
                      index: questionsIndex,
                      view: builderResponse.jsonBody,
                    ),
                  );
                });
              });
        },
        child: Padding(
          padding:
              const EdgeInsetsDirectional.fromSTEB(0, Dimens.xxsMargin, 0, 0),
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
                      color: CColors.primaryColor,
                    ),
              ),
              Visibility(
                visible: (questionsItem['last_submitted'] != 'N/A' &&
                        (questionsItem['submission_file_exists'] == null)) ||
                    questionsItem['submission_file_exists'] == true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: CColors.success,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Dimens.xxsMargin, 0, 0, Dimens.xxsMargin),
                      child: Text(
                        formatDateTwo(
                                questionsItem['date_submitted'] ?? 'N/A') ??
                            formatDate(questionsItem['last_submitted']),
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
                              color: CColors.success,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: (questionsItem['last_submitted'] != 'N/A' &&
                        (questionsItem['submission_file_exists'] == null)) ||
                    questionsItem['submission_file_exists'] == true,
                child: Column(
                  children: [
                    Visibility(
                      visible: questionsItem['total_score'] != null,
                      child: Text(
                        '${questionsItem['total_score']}/${questionsItem['points']} ${Strings.uppercasePoints}',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText3.override(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Visibility(
                      visible: questionsItem['total_score'] == null,
                      child: Text(
                        Strings.awaitingScore,
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
              Visibility(
                visible: (questionsItem['last_submitted'] == 'N/A' &&
                        questionsItem['submission_file_exists'] == null) ||
                    questionsItem['submission_file_exists'] == false,
                child: Text(
                  'Max ${questionsItem['points']} ${Strings.uppercasePoints}',
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
