import 'dart:math';

import 'package:flutter/material.dart';

/// Enum representing the triggers for animations.
enum AnimationTrigger {
  onPageLoad,
  onActionTrigger,
}

/// Class representing the state of an animation.
class AnimationState {
  /// Creates an [AnimationState] with the given [offset], [opacity], and [scale].
  const AnimationState({
    this.offset = const Offset(0, 0),
    this.opacity = 1,
    this.scale = 1,
  });

  /// The offset of the animation.
  final Offset offset;

  /// The opacity of the animation.
  final double opacity;

  /// The scale of the animation.
  final double scale;
}

/// Class representing the information for an animation.
class AnimationInfo {
  /// Creates an [AnimationInfo] with the given parameters.
  AnimationInfo({
    this.curve = Curves.easeInOut,
    required this.trigger,
    required this.duration,
    this.delay = 0,
    this.hideBeforeAnimating = true,
    this.fadeIn = false,
    required this.initialState,
    required this.finalState,
  });

  /// The curve of the animation.
  final Curve curve;

  /// The trigger for the animation.
  final AnimationTrigger trigger;

  /// The duration of the animation.
  final int duration;

  /// The delay before starting the animation.
  final int delay;

  /// Indicates whether to hide the widget before animating.
  final bool hideBeforeAnimating;

  /// Indicates whether to fade in the widget during the animation.
  final bool fadeIn;

  /// The initial state of the animation.
  final AnimationState initialState;

  /// The final state of the animation.
  final AnimationState finalState;

  /// The curved animation used for the animation.
  late CurvedAnimation curvedAnimation;
}

/// Creates the animation for a single animation info.
void createAnimation(AnimationInfo animation, TickerProvider vsync) {
  animation.curvedAnimation = CurvedAnimation(
    parent: AnimationController(
      duration: Duration(milliseconds: animation.duration),
      vsync: vsync,
    ),
    curve: animation.curve,
  );
}

/// Starts the animations triggered on page load.
void startPageLoadAnimations(
    Iterable<AnimationInfo> animations, TickerProvider vsync) {
  animations.forEach((animation) async {
    createAnimation(animation, vsync);
    await Future.delayed(
      Duration(milliseconds: animation.delay),
      () => (animation.curvedAnimation.parent as AnimationController)
          .forward(from: 0.0),
    );
  });
}

/// Sets up the trigger animations.
void setupTriggerAnimations(
    Iterable<AnimationInfo> animations, TickerProvider vsync) {
  for (var animation in animations) {
    createAnimation(animation, vsync);
  }
}

/// Extension on [Widget] to apply animations.
extension AnimatedWidgetExtension on Widget {
  Widget animated(Iterable<AnimationInfo> animationInfos) {
    final animationInfo = animationInfos.first;
    return AnimatedBuilder(
      animation: animationInfo.curvedAnimation,
      builder: (context, child) {
        if (child == null) {
          return Container();
        }
        // On Action Trigger animations are in this state when
        // they are first loaded, but before they are triggered.
        // The widget should remain as it is.
        if (animationInfo.curvedAnimation.status == AnimationStatus.dismissed) {
          if (animationInfo.hideBeforeAnimating) {
            return Opacity(
              opacity: 0,
              child: child,
            );
          } else {
            return child;
          }
        }
        var returnedWidget = child;
        if (animationInfo.initialState.offset.dx != 0 ||
            animationInfo.initialState.offset.dy != 0 ||
            animationInfo.finalState.offset.dx != 0 ||
            animationInfo.finalState.offset.dy != 0) {
          final xRange = animationInfo.finalState.offset.dx -
              animationInfo.initialState.offset.dx;
          final yRange = animationInfo.finalState.offset.dy -
              animationInfo.initialState.offset.dy;
          final xDelta = xRange * animationInfo.curvedAnimation.value;
          final yDelta = yRange * animationInfo.curvedAnimation.value;
          returnedWidget = Transform.translate(
            offset: Offset(
              animationInfo.initialState.offset.dx + xDelta,
              animationInfo.initialState.offset.dy + yDelta,
            ),
            child: returnedWidget,
          );
        }
        if (animationInfo.initialState.scale != 1 ||
            animationInfo.finalState.scale != 1) {
          final range =
              animationInfo.finalState.scale - animationInfo.initialState.scale;
          final delta = range * animationInfo.curvedAnimation.value;
          final scale = animationInfo.initialState.scale + delta;

          returnedWidget = Transform.scale(
            scale: scale,
            child: returnedWidget,
          );
        }
        if (animationInfo.fadeIn) {
          final opacityRange = animationInfo.finalState.opacity -
              animationInfo.initialState.opacity;
          final opacityDelta =
              animationInfo.curvedAnimation.value * opacityRange;
          final opacity = animationInfo.initialState.opacity + opacityDelta;

          returnedWidget = Opacity(
            // In cases where the child tree has a Material widget with elevation,
            // opacity animations may result in sudden box shadow "glitches"
            // To prevent this, opacity is animated up to but NOT including 1.0.
            // It is impossible to tell the difference between 0.998 and 1.0 opacity.
            opacity: min(0.998, opacity),
            child: returnedWidget,
          );
        }
        return returnedWidget;
      },
      child:
          animationInfos.length > 1 ? animated(animationInfos.skip(1)) : this,
    );
  }
}
