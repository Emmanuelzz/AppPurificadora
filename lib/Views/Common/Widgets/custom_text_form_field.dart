import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isNumeric;
  final int? maxLength;  // Propiedad para la longitud máxima
  final int? minLength;  // Propiedad para la longitud mínima
  final bool enabled;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isNumeric = false,
    this.maxLength,
    this.minLength,
    this.enabled = true,
  });

  String? Function(String?) get validator {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo no puede estar vacío';
      }
      if (minLength != null && value.length < minLength!) {
        return 'Debe tener al menos $minLength caracteres';
      }
      if (maxLength != null && value.length > maxLength!) {
        return 'No debe exceder $maxLength caracteres';
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          autofocus: true,
          obscureText: false,
          keyboardType: isNumeric ? TextInputType.number : null,
          inputFormatters: [
            if (isNumeric) FilteringTextInputFormatter.digitsOnly,
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength)
          ],
          validator: validator,
          maxLength: maxLength,
          enabled:  enabled,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText2,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF001C30), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0x00000000), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0x00000000), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0x00000000), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}