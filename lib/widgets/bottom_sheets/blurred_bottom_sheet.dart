import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class BlurredBottomSheet extends StatelessWidget {
  final Widget child;
  const BlurredBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          context.popRoute();
        },
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: CColors.blurColor,
                ),
                alignment: const AlignmentDirectional(0, 1),
                child: InkWell(
                    onTap: () async {}, //keeps actual background not clicking
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: CColors.primaryBackground,
                        ),
                        child: child)))));
  }
}
