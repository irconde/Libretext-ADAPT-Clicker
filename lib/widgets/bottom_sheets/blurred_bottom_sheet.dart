import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class BlurredBottomSheet extends StatelessWidget {
  final Widget child;
  const BlurredBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return InkWell(
        onTap: () async {
          context.popRoute();
        },
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: theme.blurColor,
                ),
                alignment: const AlignmentDirectional(0, 1),
                child: InkWell(
                    onTap: () async {}, //keeps actual background not clicking
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: theme.primaryBackground,
                        ),
                        child: child)))));
  }
}
