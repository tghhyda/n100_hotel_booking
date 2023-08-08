import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

part 'app_filled_button_widget.dart';

part 'app_outlined_button_widget.dart';

part 'app_text_button_widget.dart';

part 'app_button_app_bar_widget.dart';

enum AppButtonSize {
  large(size: 'large'),
  medium(size: 'medium'),
  small(size: 'small');

  final String size;

  const AppButtonSize({required this.size});
}

enum AppButtonType {
  standard(type: 'standard'),
  danger(type: 'danger'),
  circle(type: 'circle'),
  square(type: 'square');

  final String type;

  const AppButtonType({required this.type});
}

abstract class AppButtonBaseBuilder {
  @protected
  String? _buttonText;
  @protected
  bool? _isDisabled;
  @protected
  Widget? _prefixIcon;
  @protected
  Widget? _suffixIcon;
  @protected
  TextStyle? _textStyle;
  @protected
  AppButtonSize? _appButtonSize;
  @protected
  AppButtonType? _appButtonType;
  @protected
  void Function()? _onPressed;

  AppButtonBaseBuilder setButtonText(String? buttonText) {
    return this;
  }

  AppButtonBaseBuilder setIsDisabled(bool isDisabled) {
    return this;
  }

  AppButtonBaseBuilder setPrefixIcon(Widget? prefixIcon) {
    return this;
  }

  AppButtonBaseBuilder setSuffixIcon(Widget? suffixIcon) {
    return this;
  }

  AppButtonBaseBuilder setTextStyle(TextStyle? textStyle) {
    return this;
  }

  AppButtonBaseBuilder setOnPressed(void Function()? onPressed) {
    return this;
  }

  AppButtonBaseBuilder setAppButtonSize(AppButtonSize? appButtonSize) {
    return this;
  }

  AppButtonBaseBuilder setAppButtonType(AppButtonType? appButtonType) {
    return this;
  }

  Widget build(BuildContext context);
}
