import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_to_background/move_to_background.dart';
import '../components/connection_state_mixin.dart';
import '../components/custom_elevated_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class WelcomePageWidget extends ConsumerStatefulWidget {
  final bool? isFirstScreen;

  const WelcomePageWidget({Key? key, this.isFirstScreen = false})
      : super(key: key);

  @override
  ConsumerState<WelcomePageWidget> createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends ConsumerState<WelcomePageWidget>
    with ConnectionStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.isFirstScreen!) {
      startWatchingConnection();
    }
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(42, 42, 42, 24),
                      child: SvgPicture.asset(
                        'assets/images/libretexts_adapt_logo.svg',
                        width: 270,
                        height: 170,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 8),
                      child: CustomElevatedButton(
                        normalText: 'LOGIN',
                        onPressed: () async {
                          context.pushRoute(
                            const LoginRouteWidget(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 8, 32, 0),
                      child: CustomElevatedButton(
                        type: ButtonType.secondary,
                        normalText: 'CREATE ACCOUNT',
                        onPressed: () async {
                          context.pushRoute(
                            const CreateAccountWidget(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 92, 0, 0),
                      child: RichText(
                        text: TextSpan(
                            style: FlutterFlowTheme.of(context).bodyText1,
                            children: [
                              const TextSpan(text: 'Having problems? '),
                              TextSpan(
                                  text: 'Contact us',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.normal,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      context.pushRoute(
                                        ContactUsWidget(),
                                      );
                                    }),
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
    );
  }
}
