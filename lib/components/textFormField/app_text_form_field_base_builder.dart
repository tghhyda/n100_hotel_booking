import 'package:flutter/material.dart';

part 'app_text_form_field_widget.dart';
part 'app_outline_text_form_field_widget.dart';

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
  String? _initialValue;
  int? _maxLine;
  int? _minLine;
  int? _maxLength;

  AppTextFormFieldBaseBuilder setMaxLength(int maxLength){
    return this;
  }

  AppTextFormFieldBaseBuilder setOnTapSuffixIcon(
      void Function() onTapSuffixIcon);

  AppTextFormFieldBaseBuilder setMinLine(int minLine);

  AppTextFormFieldBaseBuilder setMaxLine(int maxLine);

  AppTextFormFieldBaseBuilder setController(TextEditingController controller);

  AppTextFormFieldBaseBuilder setHintText(String hintText);

  AppTextFormFieldBaseBuilder setInitialValue(String initialValue);

  AppTextFormFieldBaseBuilder setOnTap(void Function()? onTap);

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
