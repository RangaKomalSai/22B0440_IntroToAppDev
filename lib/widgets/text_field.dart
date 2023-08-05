import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool autofocus;
  final TextInputType? textInputType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Widget? child;

  const MyTextField({
    super.key,
    required this.controller,
    this.textInputAction,
    required this.labelText,
    this.textCapitalization,
    this.autofocus = false,
    this.textInputType,
    this.prefixIcon,
    this.suffixIcon,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
        fontSize: 16,
      ),
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Colors.grey
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(21),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(21),
          // ),
          floatingLabelStyle: const TextStyle(
            color: Color.fromRGBO(47, 37, 245, 1),
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
            fontSize: 18,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(47, 37, 245, 1),
                width: 2.0
            ),
            borderRadius: BorderRadius.circular(21),
          )
      ),
    );
  }
}
