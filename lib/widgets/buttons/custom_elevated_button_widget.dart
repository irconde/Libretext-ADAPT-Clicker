import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../mixins/form_state_mixin.dart';

/// Enumeration representing the type of a custom elevated button.
enum ButtonType {
  primary,
  secondary,
  external,
  shimmer,
}

/// A custom elevated button widget.
class CustomElevatedButton extends StatelessWidget {
  final ButtonType type;
  final FormStateValue? formState;
  final String normalText;
  String? errorText;
  String? successText;
  String? processingText;
  final Function onPressed;
  double? width;
  double? height;

  /// Constructs a [CustomElevatedButton].
  ///
  /// The [type] parameter specifies the type of the button.
  /// The [formState] parameter represents the state of the form.
  /// The [normalText] parameter provides the text to display when the button is in its normal state.
  /// The [errorText] parameter provides the text to display when the form has an error state.
  /// The [successText] parameter provides the text to display when the form has a success state.
  /// The [processingText] parameter provides the text to display when the form is in a processing state.
  /// The [onPressed] parameter is a callback function that will be invoked when the button is pressed.
  CustomElevatedButton({
    this.type = ButtonType.primary,
    Key? key,
    this.formState,
    required this.normalText,
    this.errorText,
    this.successText,
    this.processingText,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        surfaceTintColor: CColors.pureWhite,
        minimumSize: Size.fromHeight(height ?? Dimens.buttonHeight),
        maximumSize: Size.fromHeight(height?? 44),
        backgroundColor: _backgroundColorButton(context),
        foregroundColor: _foregroundColorButton(context),
        shape: _borderSideButton(context),
      ),
      onPressed: formState == FormStateValue.unfilled ||
              formState == FormStateValue.processing
          ? null
          : () => {onPressed()},
      child: _buildButtonChild(context),
    );
  }

  Color _foregroundColorButton(BuildContext context) {
    if (type == ButtonType.secondary) {
      return formState == FormStateValue.error
          ? CColors.failure
          : formState == FormStateValue.success
              ? CColors.success
              : CColors.primaryColor;
    } else {
      return Colors.white;
    }
  }

  RoundedRectangleBorder _borderSideButton(BuildContext context) {
    Color borderColor = formState == FormStateValue.error
        ? CColors.failure
        : formState == FormStateValue.success
            ? CColors.success
            : CColors.primaryColor;
    if (type == ButtonType.secondary) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            width: 1,
            color: borderColor,
          ));
    } else {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
    }
  }

  Color _backgroundColorButton(BuildContext context) {
    Color btnMainColor;
    switch (type) {
      case ButtonType.primary:
        btnMainColor = CColors.primaryColor;
        if (formState == FormStateValue.error) {
          btnMainColor = CColors.failure;
        } else if (formState == FormStateValue.success) {
          btnMainColor = CColors.success;
        }
        break;
      case ButtonType.secondary:
        btnMainColor = Colors.white;
        break;
      case ButtonType.external:
        btnMainColor = CColors.secondaryColor;
        break;
      case ButtonType.shimmer:
        btnMainColor = CColors.buttonShimmerBackground;
        break;
    }
    return btnMainColor;
  }

  Widget _buildButtonChild(BuildContext context) {
    if (formState == FormStateValue.processing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(processingText!),
          const SizedBox(width: 12.0),
          const SizedBox(
            width: 20.0, // Customize width
            height: 20.0, // Customize height
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black38),
              // Customize color
              strokeWidth: 3, // Customize stroke width
            ),
          ),
        ],
      );
    } else if (formState == FormStateValue.error ||
        formState == FormStateValue.success) {
      Widget icon = formState == FormStateValue.error
          ? const Icon(Icons.error_outline_outlined, color: Colors.white)
          : const Icon(Icons.check_circle_outline, color: Colors.white);
      String text =
          formState == FormStateValue.error ? errorText! : successText!;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text),
          const SizedBox(width: 12.0),
          icon,
        ],
      );
    } else {
      return Text(normalText);
    }
  }
}
