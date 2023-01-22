import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class NoCoursesWidget extends StatefulWidget {
  const NoCoursesWidget({Key? key}) : super(key: key);

  @override
  _NoCoursesWidgetState createState() => _NoCoursesWidgetState();
}

class _NoCoursesWidgetState extends State<NoCoursesWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(48, 112, 48, 96),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'Oops. it seems there are no classes registered yet',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 64, 0, 32),
                child: Image.asset(
                  'assets/images/Course_placeholder_img.png',
                  width: 283,
                  fit: BoxFit.none,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ASK YOUR ',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    'INSTRUCTOR',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FOR A ',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    'CODE TO JOIN',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryColor,
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
