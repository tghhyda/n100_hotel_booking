part of 'app_text_form_field_base_builder.dart';

class AppOutlineTextFormFieldWidget extends AppTextFormFieldBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: _controller,
          maxLength: _maxLength ?? 200,
          decoration: InputDecoration(
            prefixIcon: _prefixIcon,
            filled: true,
            fillColor: Colors.white,
            hintText: _hintText,
            enabled: true,
            contentPadding: const EdgeInsets.only(
              left: 14.0,
              bottom: 8.0,
              top: 8.0,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 14),
          validator: _validator,
          onChanged: _onChanged,
          keyboardType: _textInputType,
          onTap: _onTap,
          readOnly: _isReadOnly ?? false,
          autovalidateMode: _autoValidateMode,
          initialValue: _initialValue,
          minLines: _minLine,
          maxLines: _maxLine ?? 1,
        ),
      ],
    );
  }

  @override
  AppOutlineTextFormFieldWidget setAutoValidateMode(
      AutovalidateMode autoValidateMode) {
    _autoValidateMode = autoValidateMode;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setController(
      TextEditingController controller) {
    _controller = controller;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setDisplaySuffixIcon(bool displaySuffixIcon) {
    _displaySuffixIcon = displaySuffixIcon;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setHintText(String hintText) {
    _hintText = hintText;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setInputType(TextInputType inputType) {
    _textInputType = inputType;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setIsReadOnly(bool isReadOnly) {
    _isReadOnly = isReadOnly;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setObscureText(bool obscureText) {
    _obscureText = obscureText;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setOnChanged(void Function(String) onChanged) {
    _onChanged = _onChanged;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setPrefixIcon(Icon prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setValidator(
      String? Function(String? value)? validator) {
    _validator = validator;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setIsDisable(bool isDisable) {
    _isDisable = isDisable;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setOnTapSuffixIcon(
      void Function() onTapSuffixIcon) {
    _onTapSuffixIcon = onTapSuffixIcon;
    return this;
  }

  @override
  AppTextFormFieldBaseBuilder setOnTap(void Function()? onTap) {
    _onTap = onTap;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setMaxLine(int maxLine) {
    _maxLine = maxLine;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setMinLine(int minLine) {
    _minLine = _minLine;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setInitialValue(String initialValue) {
    _initialValue = initialValue;
    return this;
  }

  @override
  AppOutlineTextFormFieldWidget setMaxLength(int maxLength) {
    _maxLength = maxLength;
    return this;
  }
}
