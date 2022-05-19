import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController? textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final int maxlines;
  final bool isIntro;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool showLabelText;
  final int maxLength;

  const CustomInputField(
      {Key? key,
      required this.icon,
      required this.placeholder,
      this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.maxlines = 1,
      this.isIntro = false,
      this.validator,
      this.onChanged,
      this.initialValue,
      this.maxLength = 500,
      this.showLabelText = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: maxLength == 500 ? null : maxLength,
        controller: textController,
        autocorrect: false,
        obscureText: isPassword,
        keyboardType: keyboardType,
        maxLines: maxlines,
        validator: validator,
        onChanged: onChanged,
        initialValue: initialValue,
        style: isIntro ? TextStyle(fontSize: 18, color: Colors.black) : null,
        decoration: isIntro
            ? InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.intro,
                ),
                hintText: placeholder,
                labelText: placeholder,
                floatingLabelStyle: TextStyle(
                    color: AppTheme.intro,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                labelStyle: TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.intro),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.intro),
                    borderRadius: BorderRadius.circular(10)))
            : InputDecoration(
                prefixIcon: Icon(icon),
                hintText: placeholder,
                labelText: showLabelText ? placeholder : null));
  }
}
