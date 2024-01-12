import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_to_background/move_to_background.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import '../../mixins/connection_state_mixin.dart';
import '../../widgets/buttons/custom_elevated_button_widget.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Screen displayed when the app is launched
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  //local
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (dummy) { MoveToBackground.moveTaskToBack();},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: CColors.primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExcludeSemantics(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            Dimens.lmMargin,  Dimens.lmMargin,  Dimens.lmMargin,  Dimens.lmMargin),
                        child: SvgPicture.asset(
                          'assets/images/libretexts_adapt_logo.svg',
                          width: 270,
                          height: 170,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, 0, Dimens.mmMargin, Dimens.xsMargin),
                      child: CustomElevatedButton(
                        normalText: Strings.loginBtnLabel,
                        onPressed: () async {
                          context.pushRoute(
                            const LoginScreenWidget(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, Dimens.xsMargin, Dimens.mmMargin, 0),
                      child: CustomElevatedButton(
                        type: ButtonType.secondary,
                        normalText: Strings.createAccountBtnLabel,
                        onPressed: () async {
                          context.pushRoute(
                            const CreateAccountScreen(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, Dimens.xxMargin, 0, 0),
                      child: RichText(
                        text: TextSpan(
                            style: theme.bodyText1,
                            children: [
                              const TextSpan(text: Strings.havingProblems),
                              TextSpan(
                                  text: Strings.contactus,
                                  style: theme
                                      .bodyText1
                                      .override(
                                        color: CColors.primaryColor,
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Open Sans',
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      context.pushRoute(
                                        ContactUsScreen(),
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
    );
  }
}
