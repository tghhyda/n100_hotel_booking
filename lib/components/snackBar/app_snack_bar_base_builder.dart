import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:get/get.dart';

part 'app_snack_bar_widget.dart';

enum AppSnackBarStatus { info, error, warning, success }

enum AppSnackBarType { informMessage, toastMessage }

abstract class AppSnackBarBaseBuilder {
  @protected
  late final Widget? _content;
  @protected
  String? _labelText;
  @protected
  Widget? _prefixWidget;
  @protected
  Widget? _suffixWidget;
  @protected
  AppSnackBarStatus? _appSnackBarStatus;
  @protected
  AppSnackBarType? _appSnackBarType;
  @protected
  String? _buttonText;
  @protected
  EdgeInsets? _marginSnackBar;
  @protected
  void Function()? _onPress;
  @protected
  SnackPosition? _showOnTop;

  AppSnackBarBaseBuilder setContent(Widget? content);

  AppSnackBarBaseBuilder setAppSnackBarStatus(
      AppSnackBarStatus? appSnackBarStatus);

  AppSnackBarBaseBuilder setAppSnackBarType(AppSnackBarType? appSnackBarType);

  AppSnackBarBaseBuilder setLabelText(String? labelText) {
    return this;
  }

  AppSnackBarBaseBuilder setPrefixWidget(Widget? prefixWidget) {
    return this;
  }

  AppSnackBarBaseBuilder setSuffixWidget(Widget? suffixWidget) {
    return this;
  }

  AppSnackBarBaseBuilder setButtonText(String? buttonText) {
    return this;
  }

  AppSnackBarBaseBuilder setOnPress(void Function()? onPress) {
    return this;
  }

  AppSnackBarBaseBuilder setMarginSnackBar(EdgeInsets? marginSnackBar) {
    return this;
  }

  AppSnackBarBaseBuilder setShowOnTop(SnackPosition? showOnTop) {
    return this;
  }

  void showSnackBar(BuildContext context);
}
