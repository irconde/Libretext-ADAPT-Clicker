import 'dart:ui';
import 'package:adapt_clicker/constants/dimens.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

/// Widget that displays a blurred bottom sheet with a given child widget.
class BlurredBottomSheet extends StatelessWidget {
  final Widget child;
  final bool centered;
  /// Constructs a [BlurredBottomSheet] with the given [child].
  const BlurredBottomSheet({Key? key, required this.child, this.centered = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.popRoute();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: Dimens.blurPercent, sigmaY: Dimens.blurPercent),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: CColors.blurColor,
          ),
          alignment: const AlignmentDirectional(0, 1),
          child: Column(
              mainAxisAlignment: centered ? MainAxisAlignment.center: MainAxisAlignment.end,
              children: [
              InkWell(
                onTap: () async {}, // keeps actual background from being clickable
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(Dimens.sMargin),
                      topRight: const Radius.circular(Dimens.sMargin),
                      bottomLeft: centered ? const Radius.circular(Dimens.sMargin): Radius.zero,
                      bottomRight: centered ? const Radius.circular(Dimens.sMargin): Radius.zero,
                    ),
                    color: CColors.primaryBackground,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
