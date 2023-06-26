import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Represents a page that displays a poll.
@RoutePage()
class PollWidget extends StatefulWidget {
  const PollWidget({
    Key? key,
    @PathParam('name') this.assignmentName,
    @PathParam('poll') this.poll,
  }) : super(key: key);

  /// The name of the assignment.
  final String? assignmentName;

  /// The poll data.
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
            Strings.poll,
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
                                  text: Strings.remainingTime,
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
                    child: Card(
                      elevation: 2,
                      child: SizedBox(
                        height: 400,
                        child: InAppWebView(
                          initialUrlRequest: null,
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
                    )),
              ]),
        ));
  }
}

void injectViewport(InAppWebViewController controller) async {
  await controller.evaluateJavascript(
      source:
          '''var flutterViewPort=document.createElement("meta"); flutterViewPort.name = "viewport"; flutterViewPort.content = "width=400, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"; document.getElementsByTagName("head")[0].appendChild(flutterViewPort);''');
}
