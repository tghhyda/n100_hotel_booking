part of 'app_text_form_field_base_builder.dart';

class AppTextFormFieldWidget extends AppTextFormFieldBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: _controller,
      obscureText: _obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: _prefixIcon,
        suffixIcon: _displaySuffixIcon ?? false
            ? IconButton(
                icon: Icon(
                    _obscureText ?? false ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  _onTapSuffixIcon?.call();
                },
              )
            : null,
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
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
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
    );
  }

  @override
  AppTextFormFieldWidget setAutoValidateMode(
      AutovalidateMode autoValidateMode) {
    _autoValidateMode = autoValidateMode;
    return this;
  }

  @override
  AppTextFormFieldWidget setController(TextEditingController controller) {
    _controller = controller;
    return this;
  }

  @override
  AppTextFormFieldWidget setDisplaySuffixIcon(bool displaySuffixIcon) {
    _displaySuffixIcon = displaySuffixIcon;
    return this;
  }

  @override
  AppTextFormFieldWidget setHintText(String hintText) {
    _hintText = hintText;
    return this;
  }

  @override
  AppTextFormFieldWidget setInputType(TextInputType inputType) {
    _textInputType = inputType;
    return this;
  }

  @override
  AppTextFormFieldWidget setIsReadOnly(bool isReadOnly) {
    _isReadOnly = isReadOnly;
    return this;
  }

  @override
  AppTextFormFieldWidget setObscureText(bool obscureText) {
    _obscureText = obscureText;
    return this;
  }

  @override
  AppTextFormFieldWidget setOnChanged(void Function(String) onChanged) {
    _onChanged = _onChanged;
    return this;
  }

  @override
  AppTextFormFieldWidget setPrefixIcon(Icon prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppTextFormFieldWidget setValidator(
      String? Function(String? value)? validator) {
    _validator = validator;
    return this;
  }

  @override
  AppTextFormFieldWidget setIsDisable(bool isDisable) {
    _isDisable = isDisable;
    return this;
  }

  @override
  AppTextFormFieldWidget setOnTapSuffixIcon(void Function() onTapSuffixIcon) {
    _onTapSuffixIcon = onTapSuffixIcon;
    return this;
  }

  @override
  AppTextFormFieldBaseBuilder setOnTap(void Function()? onTap) {
    _onTap = onTap;
    return this;
  }

  @override
  AppTextFormFieldWidget setInitialValue(String initialValue) {
    _initialValue = initialValue;
    return this;
  }
}
