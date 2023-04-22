import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'form_state_mixin.dart';

class SubmitButton extends StatelessWidget {
  final FormStateValue formState;
  final String normalText;
  final String errorText;
  String? processingText;
  final Function onPressed;

  SubmitButton({
    Key? key,
    required this.formState,
    required this.normalText,
    required this.errorText,
    this.processingText = 'Submitting request',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        surfaceTintColor: FlutterFlowTheme.of(context).primaryBtnText,
        minimumSize: const Size.fromHeight(48),
        backgroundColor: _colorButton(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: formState == FormStateValue.unfilled ||
              formState == FormStateValue.processing
          ? null
          : () => {onPressed()},
      child: _buildButtonChild(context),
    );
  }

  Color _colorButton(BuildContext context) {
    Color btnMainColor = FlutterFlowTheme.of(context).primaryColor;
    if (formState == FormStateValue.error) {
      btnMainColor = FlutterFlowTheme.of(context).failure;
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
          Text(errorText),
          const SizedBox(width: 12.0),
          icon,
        ],
      );
    } else {
      return Text(normalText);
    }
  }
}
