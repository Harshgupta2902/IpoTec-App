import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

typedef OnTap = void Function(String value);

class GrowTextField extends StatelessWidget {
  const GrowTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.suffix,
    this.enabled,
    this.onTap,
    this.readOnly,
    this.keyboardType,
    this.inputFormatter,
    this.initialValue,
    this.maxLines,
    this.fillColor,
    this.validationMode,
    this.textInputAction,
    this.label,
    this.obscure = false,
    this.prefix,
    this.textColor,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final OnTap? onTap;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscure;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? label;
  final List<TextInputFormatter>? inputFormatter;
  final Color? fillColor;
  final Color? textColor;
  final AutovalidateMode? validationMode;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      enabled: enabled,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      onTap: () {
        onTap?.call(controller.text);
      },
      obscureText: obscure!,
      textInputAction: textInputAction,
      cursorColor: Colors.green,
      maxLength: maxLines,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: textColor ?? AppColors.darkTextColor,
          ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 9),
        fillColor: fillColor ?? AppColors.alabaster,
        label: Text(hintText),
        hintText: label,
        prefixIcon: prefix,
        labelStyle: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: textColor ?? AppColors.darkTextColor),
        suffixIcon: suffix,
        filled: true,
        isDense: true,
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.suffix,
    this.enabled,
    this.onTap,
    this.readOnly,
    this.keyboardType,
    this.inputFormatter,
    this.initialValue,
    this.maxLines,
    this.fillColor,
    this.validationMode,
    this.textInputAction,
    this.label,
    this.obscure = false,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final OnTap? onTap;
  final Widget? suffix;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscure;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? label;
  final List<TextInputFormatter>? inputFormatter;
  final Color? fillColor;
  final AutovalidateMode? validationMode;
  final TextInputAction? textInputAction;

  static OutlineInputBorder activeBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        TextFormField(
          inputFormatters: inputFormatter,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
          enabled: enabled,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          onTap: () {
            onTap?.call(controller.text);
          },
          obscureText: obscure!,
          textInputAction: textInputAction,
          cursorColor: AppColors.black,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            fillColor: AppColors.whiteSmoke,
            labelStyle:
                Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.darkTextColor),
            suffixIcon: suffix,
            filled: true,
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
        ),
      ],
    );
  }
}
