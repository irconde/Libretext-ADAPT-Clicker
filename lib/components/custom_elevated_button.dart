import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'form_state_mixin.dart';

enum ButtonType { primary, secondary, external }

class CustomElevatedButton extends StatelessWidget {
  final ButtonType type;
  final FormStateValue? formState;
  final String normalText;
  String? errorText;
  String? processingText;
  final Function onPressed;

  CustomElevatedButton({
    this.type = ButtonType.primary,
    Key? key,
    this.formState,
    required this.normalText,
    this.errorText,
    this.processingText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        surfaceTintColor: FlutterFlowTheme.of(context).primaryBtnText,
        minimumSize: const Size.fromHeight(44),
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
          ? FlutterFlowTheme.of(context).failure
          : FlutterFlowTheme.of(context).primaryColor;
    } else {
      return Colors.white;
    }
  }

  RoundedRectangleBorder _borderSideButton(BuildContext context) {
    Color borderColor = formState == FormStateValue.error
        ? FlutterFlowTheme.of(context).failure
        : FlutterFlowTheme.of(context).primaryColor;
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
        btnMainColor = FlutterFlowTheme.of(context).primaryColor;
        if (formState == FormStateValue.error) {
          btnMainColor = FlutterFlowTheme.of(context).failure;
        }
        break;
      case ButtonType.secondary:
        btnMainColor = Colors.white;
        break;
      case ButtonType.external:
        btnMainColor = FlutterFlowTheme.of(context).secondaryColor;
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
    } else if (formState == FormStateValue.error) {
      Widget icon =
          const Icon(Icons.error_outline_outlined, color: Colors.white);
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(errorText!),
          const SizedBox(width: 12.0),
          icon,
        ],
      );
    } else {
      return Text(normalText);
    }
  }
}
