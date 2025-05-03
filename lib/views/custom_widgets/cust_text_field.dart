import 'package:flutter/material.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';

class CustTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool isRequired;
  final String? requiredErrorMessage;
  final int? minLength;
  final String? minLengthErrorMessage;
  final int? maxLength;
  final RegExp? pattern;
  final String? patternErrorMessage;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color? fillColor;
  final bool autoFocus;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final bool readOnly;
  final Function()? onTap;

  const CustTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.isRequired = false,
    this.requiredErrorMessage = 'This field is required',
    this.minLength,
    this.minLengthErrorMessage = 'Minimum length is {minLength} characters',
    this.maxLength,
    this.pattern,
    this.patternErrorMessage = 'Invalid format',
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    this.fillColor,
    this.autoFocus = false,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        textInputAction: textInputAction,
        focusNode: focusNode,
        autofocus: autoFocus,
        maxLines: maxLines,
        minLines: minLines,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,

        decoration: InputDecoration(
          labelStyle: TextStyle(color: myGoldenColor),
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: fillColor != null,
          fillColor: fillColor,
          contentPadding:
              contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

          /* Focused border */
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: myGoldenColor),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          //focusColor: myGoldenColor,

          /* Error borders */
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.5, color: myGoldenColor),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorStyle: TextStyle(color: myGoldenColor),
        ),

        validator: (value) {
          // Simplified empty check
          if (isRequired && (value == null || value.trim().isEmpty)) {
            return requiredErrorMessage;
          }

          // Only validate length if there's actual content
          if (value != null && value.isNotEmpty) {
            if (minLength != null && value.length < minLength!) {
              return minLengthErrorMessage?.replaceAll(
                '{minLength}',
                minLength.toString(),
              );
            }

            if (maxLength != null && value.length > maxLength!) {
              return 'Maximum length is $maxLength characters';
            }

            if (pattern != null && !pattern!.hasMatch(value)) {
              return patternErrorMessage;
            }
          }

          return null;
        },
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}


/*
  ♠ How to use:
    → Basic required text
      TextFieldForm(
        controller: TextEditingController(),
        labelText: 'Username',
        isRequired: true,
      )
    
    → Email with validation
      TextFieldForm(
        controller: TextEditingController(),
        labelText: 'Email',
        keyboardType: TextInputType.emailAddress,
        isRequired: true,
        pattern: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
        patternErrorMessage: 'Please enter a valid email',
      )
    
    → Password with minimum length
      TextFieldForm(
        controller: TextEditingController(),
        labelText: 'Password',
        obscureText: true,
        isRequired: true,
        minLength: 8,
        minLengthErrorMessage: 'Password must be at least 8 characters',
      )

    → Optional Field with Custom Styling
      TextFieldForm(
        controller: TextEditingController(),
        labelText: 'Bio',
        hintText: 'Tell us about yourself',
        maxLines: 3,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.all(16),
      )

    → Field with Prefix Icon and OnChange
      TextFieldForm(
        controller: TextEditingController(),
        labelText: 'Search',
        prefixIcon: Icon(Icons.search),
        onChanged: (value) {
          // Handle search as user types
        },
      )

    → Using in a Form
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();

    Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldForm(
            controller: _usernameController,
            labelText: 'Username',
            isRequired: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, proceed
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    )


 */