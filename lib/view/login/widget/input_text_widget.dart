import 'package:flutter/material.dart';
import 'package:getx_mvvm/utils/utils.dart';

class InputTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String validatorMessage;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;

  const InputTextWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.validatorMessage,
    this.obscureText = false,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          Utils.snackBar(hintText, validatorMessage);
          return validatorMessage;
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
