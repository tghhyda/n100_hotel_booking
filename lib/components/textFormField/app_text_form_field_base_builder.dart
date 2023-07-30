import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_text_form_field_widget.dart';

abstract class AppTextFormFieldBaseBuilder {
  late final TextEditingController _controller;
  String? _hintText;
  TextInputType? _textInputType;
  void Function(String)? _onChanged;
  bool? _obscureText;
  bool? _displaySuffixIcon;
  Icon? _prefixIcon;
  void Function()? _onTap;
  bool? _isReadOnly;
  bool? _isDisable;
  AutovalidateMode? _autoValidateMode;
  String? Function(String? value)? _validator;
  void Function()? _onTapSuffixIcon;

  AppTextFormFieldBaseBuilder setOnTapSuffixIcon(
      void Function() onTapSuffixIcon);

  AppTextFormFieldBaseBuilder setController(TextEditingController controller);

  AppTextFormFieldBaseBuilder setHintText(String hintText);

  AppTextFormFieldBaseBuilder setInputType(TextInputType inputType);

  AppTextFormFieldBaseBuilder setOnChanged(void Function(String) onChanged);

  AppTextFormFieldBaseBuilder setObscureText(bool obscureText);

  AppTextFormFieldBaseBuilder setDisplaySuffixIcon(bool displaySuffixIcon);

  AppTextFormFieldBaseBuilder setPrefixIcon(Icon prefixIcon);

  AppTextFormFieldBaseBuilder setIsReadOnly(bool isReadOnly);

  AppTextFormFieldBaseBuilder setIsDisable(bool isDisable);

  AppTextFormFieldBaseBuilder setAutoValidateMode(
      AutovalidateMode autoValidateMode);

  AppTextFormFieldBaseBuilder setValidator(
      String? Function(String? value)? validator);

  Widget build(BuildContext context);
}
