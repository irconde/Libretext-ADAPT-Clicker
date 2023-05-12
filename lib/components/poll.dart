import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../utils/stored_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class PollWidget extends StatefulWidget {
  const PollWidget({
    Key? key,
    @PathParam('name') this.assignmentName,
    @PathParam('poll') this.poll,
  }) : super(key: key);

  final String? assignmentName;
  final dynamic poll;

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  TextEditingController? textController;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState!(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    textController = TextEditingController();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: true,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        cacheEnabled: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    final question = widget.poll;

    /*-----------------Building Page-----------------------*/
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 24,
              color: FlutterFlowTheme.of(context).tertiaryColor,
            ),
            onPressed: () {
              context.popRoute();
            },
          ),
          title: Text(
            'Poll',
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: FlutterFlowTheme.of(context).primaryColor,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Icon(
                          Icons.timer,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          size: 28,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            style: FlutterFlowTheme.of(context).title3,
                            children: [
                              const TextSpan(
                                text: 'REMAINING TIME: ',
                              ),
                              TextSpan(
                                  text: "${widget.poll['timer'] ?? '0:00'}",
                                  style: FlutterFlowTheme.of(context).title2)
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 80, 0, 24),
                child: AppState().isBasic
                    ? Card(
                        elevation: 2,
                        child: SizedBox(
                          height: 400,
                          child: InAppWebView(
                            initialUrlRequest: URLRequest(
                                url: Uri.parse(
                                    AppState().question['technology_iframe'])),
                            onWebViewCreated: (controller) {
                              webViewController = controller;
                              injectViewport(controller);
                            },
                            onLoadStart: (controller, uri) {
                              injectViewport(controller);
                            },
                            initialOptions: options,
                            gestureRecognizers: Set()
                              ..add(Factory(() => EagerGestureRecognizer()))
                              ..add(Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer())),
                          ),
                        ),
                      )
                    : FutureBuilder<ApiCallResponse>(
                        future: GetNonTechnologyIframeCall.call(
                          pageId: getJsonField(
                            AppState().question,
                            r'''$.page_id''',
                          ),
                          token: StoredPreferences.authToken,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          final htmlViewGetNonTechnologyIframeResponse =
                              snapshot.data!;
                          return Html(
                            data: htmlViewGetNonTechnologyIframeResponse
                                .elements.outerHtml,
                          );
                        },
                      ),
              ),
              if (functions.isTextSubmission(getJsonField(
                AppState().question,
                r'''$.open_ended_submission_type''',
              ).toString()))
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      controller: textController,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: '[Some hint text...]',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      maxLines: 16,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: FFButtonWidget(
                        onPressed: () {
                          // TODO. Check this. What is this for?
                          //print('Button pressed ...');
                        },
                        text: 'Submit',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                  ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}

void injectViewport(InAppWebViewController controller) async {
  await controller.evaluateJavascript(
      source:
          '''var flutterViewPort=document.createElement("meta"); flutterViewPort.name = "viewport"; flutterViewPort.content = "width=400, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"; document.getElementsByTagName("head")[0].appendChild(flutterViewPort);''');
}
