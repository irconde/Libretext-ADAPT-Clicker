import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/screens/content/question_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/utils.dart';

class AssignmentGridWidget extends ConsumerStatefulWidget {
  /// A widget representing a grid item in the assignment grid.
  /// The [questionsItem] represents the question item for the assignment.
  /// The [builderResponse] represents the builder response for the assignment.
  /// The [assignmentSummary] represents the summary of the assignment.
  /// The [questionsIndex] represents the index of the question.
  const AssignmentGridWidget(
      {Key? key,
      this.questionsItem,
      required this.assignmentSummary,
      this.builderResponse,
      required this.questionsIndex})
      : super(key: key);

  final dynamic questionsItem;
  final dynamic builderResponse;
  final Map<String, dynamic> assignmentSummary;
  final int questionsIndex;

  @override
  ConsumerState<AssignmentGridWidget> createState() =>
      AssignmentGridWidgetState();
}

class AssignmentGridWidgetState extends ConsumerState<AssignmentGridWidget>
    with ConnectionStateMixin {

  //Local
  dynamic questionsItem;
  late Map<String, dynamic> assignmentSummary;
  dynamic builderResponse;
  late int questionsIndex;

  @override
  void initState() {
    super.initState();
    questionsItem = widget.questionsItem;
    assignmentSummary = widget.assignmentSummary;
    builderResponse = widget.builderResponse;
    questionsIndex = widget.questionsIndex;
  }

  /// Formats the given [date] string into a formatted date string.
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

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Container(
      color: CColors.primaryBackground,
      child: InkWell(
        onTap: () async {
          if (!checkConnection()) return;
          setState(() => AppState().view = builderResponse.jsonBody);
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
                    child: SizedBox(
                      height: double.infinity,
                      child: QuestionScreen(
                        assignmentName: assignmentSummary['name'],
                        index: questionsIndex,
                        view: builderResponse.jsonBody,
                        isIndex: true,
                      ),
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
                style: theme.title2.override(
                      fontSize: Dimens.giantFontSize,
                      fontFamily: 'Open Sans',
                      color: CColors.primaryColor,
                    ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] != 'N/A',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IIcons.completedAssignmentCheck,
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Dimens.xxsMargin, 0, 0, Dimens.xxsMargin),
                      child: Text(
                        formatDate(questionsItem['last_submitted']),
                        textAlign: TextAlign.center,
                        style: theme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: CColors.success,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] != 'N/A',
                child: Text(
                  '${questionsItem['total_score'] ?? 'Max'}/${questionsItem['points']} ${Strings.uppercasePoints}',
                  textAlign: TextAlign.center,
                  style: theme.bodyText3
                ),
              ),
              Visibility(
                visible: questionsItem['last_submitted'] == 'N/A',
                child: Text(
                  'Max ${questionsItem['points']} ${Strings.uppercasePoints}',
                  textAlign: TextAlign.center,
                  style: theme.bodyText3
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
