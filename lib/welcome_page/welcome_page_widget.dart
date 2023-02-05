import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_to_background/move_to_background.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

class WelcomePageWidget extends ConsumerWidget {
  final bool? isFirstScreen;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  WelcomePageWidget({this.isFirstScreen = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (this.isFirstScreen != null && this.isFirstScreen == true) {
      final AsyncValue<ConnectivityStatus> connectivityStatusProvider =
          ref.watch(provider);
      ConnectivityStatus? status;
      connectivityStatusProvider.whenData((value) => {status = value});
      if (status != null) {
        if (status != ConnectivityStatus.isConnected) {
          ref.read(provider.notifier).startWatchingConnectivity();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (status == null || status == ConnectivityStatus.initializing)
            return;
          functions.showSnackbar(context, status!);
        });
      }
    }

    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional(0, 0),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -0.4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -0.6),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(42, 42, 42, 24),
                            child: SvgPicture.asset(
                              'assets/images/libretexts_adapt_logo.svg',
                              width: 270,
                              height: 170,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).primaryColor,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              minimumSize: Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () async {
                              context.pushRoute(
                                LoginRouteWidget(
                                  onSubmit: (String? value) {},
                                ),
                              );
                            },
                            child: const Text('LOGIN'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(32, 8, 32, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  FlutterFlowTheme.of(context).primaryColor,
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              minimumSize: Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () async {
                              context.pushRoute(
                                CreateAccountWidget(
                                  onSubmit: (String? value) {},
                                ),
                              );
                            },
                            child: const Text('CREATE ACCOUNT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 91),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.06, 1),
                            child: Text(
                              'Having problems? ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.06, 1),
                            child: InkWell(
                              onTap: () async {
                                context.pushRoute(
                                  ContactUsWidget(
                                    onSubmit: (String? value) {},
                                  ),
                                );
                              },
                              child: Text(
                                'Contact us',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
