import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_to_background/move_to_background.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

@RoutePage()
class WelcomePageWidget extends ConsumerStatefulWidget {
  const WelcomePageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomePageWidget> createState() => _WelcomePageWidgetState();
}


class _WelcomePageWidgetState extends ConsumerState<WelcomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    {
      final AsyncValue<ConnectivityStatus> connectivityStatusProvider =
      ref.watch(provider);
      ConnectivityStatus? status;
      connectivityStatusProvider.whenData((value) => {status = value});
      if (status != null) {
        if (status != ConnectivityStatus.isConnected) {
          ref.read(provider.notifier).startWatchingConnectivity();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (status == null || status == ConnectivityStatus.initializing) {
            return;
          }
          functions.showSnackbar(context, status!);
        });
      }

      return WillPopScope(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme
              .of(context)
              .primaryBackground,
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                            FlutterFlowTheme
                                .of(context)
                                .primaryBtnText,
                            backgroundColor:
                            FlutterFlowTheme
                                .of(context)
                                .primaryColor,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            minimumSize: const Size.fromHeight(36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () async {
                            context.pushRoute(
                              const LoginPageWidget(),
                            );
                          },
                          child: const Text('LOGIN'),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(32, 8, 32, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                            FlutterFlowTheme
                                .of(context)
                                .primaryColor,
                            backgroundColor:
                            FlutterFlowTheme
                                .of(context)
                                .primaryBackground,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            minimumSize: const Size.fromHeight(36),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: FlutterFlowTheme
                                    .of(context)
                                    .primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () async {
                            context.pushRoute(
                              const CreateAccountWidget(),
                            );
                          },
                          child: const Text('CREATE ACCOUNT'),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 92, 0, 0),
                        child: RichText(
                          text: TextSpan(
                              style: FlutterFlowTheme
                                  .of(context)
                                  .bodyText1,
                              children: [
                                const TextSpan(text: 'Having problems? '),
                                TextSpan(
                                    text: 'Contact us',
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                      color: FlutterFlowTheme
                                          .of(context)
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
}
