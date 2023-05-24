import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/colors.dart';
import '../../utils/app_theme.dart';
import '../buttons/custom_button_widget.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../backend/user_stored_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
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
        backgroundColor: CColors.primaryBackground,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CColors.primaryBackground,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 24,
              color: CColors.tertiaryColor,
            ),
            onPressed: () {
              context.popRoute();
            },
          ),
          title: Text(
            'Poll',
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: AppTheme.of(context).bodyText1.override(
                fontFamily: 'Open Sans',
                color: CColors.primaryColor,
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
                color: CColors.primaryColor,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Icon(
                          Icons.timer,
                          color: CColors.primaryBackground,
                          size: 28,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            style: AppTheme.of(context).title3,
                            children: [
                              const TextSpan(
                                text: 'REMAINING TIME: ',
                              ),
                              TextSpan(
                                  text: "${widget.poll['timer'] ?? '0:00'}",
                                  style: AppTheme.of(context).title2)
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
                          token: UserStoredPreferences.authToken,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return const Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color: CColors.primaryColor,
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
              if (isTextSubmission(getJsonField(
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
                        hintStyle: AppTheme.of(context).bodyText2,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CColors.noColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CColors.noColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CColors.noColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CColors.noColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: AppTheme.of(context).bodyText1,
                      maxLines: 16,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: CustomButtonWidget(
                        onPressed: () {
                          // TODO. Check this. What is this for?
                          //print('Button pressed ...');
                        },
                        text: 'Submit',
                        options: ButtonOptions(
                          width: 130,
                          height: 40,
                          color: CColors.primaryColor,
                          textStyle: AppTheme.of(context).subtitle2.override(
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
