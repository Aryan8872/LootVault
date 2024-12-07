import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowInputbox extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final Color fillColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry contentPadding;
  final BoxDecoration? boxDecoration;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle? inputTextStyle;
  final double? inputBoxWidth;

  const ShadowInputbox({
    required this.labelText,
    this.prefixIcon,
    this.fillColor = Colors.white,
    this.labelStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    this.boxDecoration,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.inputTextStyle,
    this.inputBoxWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputBoxWidth?? inputBoxWidth,
      decoration:
          BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(26),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: inputTextStyle,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
          ),

            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: const BorderSide(width: 1, color: Colors.blue),
          ),
        
          filled: true,
          fillColor: fillColor,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 20,
                  color: Colors.black54,
                )
              : null,
          labelText: labelText,
          labelStyle: labelStyle ??
              const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
