import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final int maxlines;
  final bool isIntro;

  const CustomInputField(
      {Key? key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.maxlines = 1,
      this.isIntro = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textController,
        autocorrect: false,
        obscureText: isPassword,
        keyboardType: keyboardType,
        maxLines: maxlines,
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
                labelText: placeholder));
  }
}
