import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class NoCoursesWidget extends StatefulWidget {
  const NoCoursesWidget({Key? key}) : super(key: key);

  @override
  State<NoCoursesWidget> createState() => _NoCoursesWidgetState();
}

/// The state for the [NoCoursesWidget].
class _NoCoursesWidgetState extends State<NoCoursesWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(48, 112, 48, 96),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Text(
                Strings.noCoursesMsg,
                textAlign: TextAlign.center,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: CColors.secondaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 64, 0, 32),
                child: ExcludeSemantics(
                  child: SvgPicture.asset(
                    'assets/images/no_courses.svg',
                    width: 283,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.askYour,
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: CColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    Strings.instructor,
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: CColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.forA,
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: CColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    Strings.codeToJoin,
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: CColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
