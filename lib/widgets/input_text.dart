import 'package:flutter/material.dart';


class InputText extends StatelessWidget {

  final String label;
  final bool isPassword;
  final double fontSize;
  final String? Function(String? text)? validator;
  final TextInputType keyboardType;
  final bool borderEnabled;
  final void Function(String text) onChanged;

  const InputText({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.borderEnabled = true,
    this.fontSize = 15,
    required this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: fontSize ,
      ),
      obscureText: isPassword,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(

        border: borderEnabled? const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12)
        ) : InputBorder.none,
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        labelStyle: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w400
        )
      ),
    );
  }
}