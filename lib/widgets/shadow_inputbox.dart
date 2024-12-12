import 'package:flutter/material.dart';

class ShadowInputbox extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final Color fillColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry contentPadding;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle? inputTextStyle;
  final double? inputBoxWidth;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged; // Real-time validation callback
  final String? errorText; // Error text for validation

  const ShadowInputbox({
    required this.labelText,
    this.prefixIcon,
    this.fillColor = Colors.white,
    this.labelStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.inputTextStyle,
    this.inputBoxWidth,
    this.validator,
    this.onChanged, // Handle real-time changes
    this.errorText, // Pass the error text
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align error text to the start
      children: [
        // Material widget to create shadow effect
        Material(
          elevation: 20.0, // Adjust elevation for the shadow effect
          shadowColor: Colors.black, // Shadow color
          borderRadius: BorderRadius.circular(12), // Border radius for the shadow box
          child: Container(
            width: inputBoxWidth ?? inputBoxWidth,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(12), // Rounded corners for shadow
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: inputTextStyle,
              validator: validator,  // Use the validator function
              onChanged: onChanged,  // Trigger real-time validation or update
              decoration: InputDecoration(
                icon: prefixIcon != null
                    ? Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                          prefixIcon,
                          color: Color(0xff224597), // Customize icon color
                        ),
                    )
                    : null,
                hintText: labelText, // Hint text instead of label
                filled: true,
                fillColor: fillColor,
                contentPadding: contentPadding,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.white, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
          ),
        ),
        // Error message displayed below the input box (outside the shadow box)
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
