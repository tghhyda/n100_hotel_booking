part of 'app_button_base_builder.dart';

class AppFilledButtonWidget extends AppButtonBaseBuilder {
  @override
  AppFilledButtonWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppFilledButtonWidget setIsDisabled(bool isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppFilledButtonWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  @override
  AppFilledButtonWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppFilledButtonWidget setSuffixIcon(Widget? suffixIcon) {
    _suffixIcon = suffixIcon;
    return this;
  }

  @override
  AppFilledButtonWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  AppFilledButtonWidget setAppButtonSize(AppButtonSize? appButtonSize) {
    _appButtonSize = appButtonSize;
    return this;
  }

  @override
  AppFilledButtonWidget setAppButtonType(AppButtonType? appButtonType) {
    _appButtonType = appButtonType;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    if (_prefixIcon == null && _buttonText == null) return const SizedBox();
    if (_appButtonType == AppButtonType.circle) {
      return _circle(context);
    }
    if (_appButtonType == AppButtonType.square) {
      return _square(context);
    }
    return _standard(context);
  }

  Widget _standard(BuildContext context) {
    return FilledButton(
      onPressed: _isDisabled == true ? null : _onPressed,
      style: _buttonStyle(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_prefixIcon != null) _prefixIcon!,
          if (_prefixIcon != null && _buttonText != null)
            SizedBox(width: AppThemeExt.of.majorPaddingScale(6 / 4)),
          if (_buttonText != null)
            AppTextBody1Widget()
                .setText(_buttonText!)
                .setColor(AppColors.of.grayColor[1])
                .build(context),
          if (_suffixIcon != null)
            SizedBox(width: AppThemeExt.of.majorPaddingScale(2)),
          if (_suffixIcon != null) _suffixIcon!,
        ],
      ),
    );
  }

  Widget _circle(BuildContext context) {
    double buttonPadding = AppThemeExt.of.majorScale(13 / 4);
    if (_appButtonSize == AppButtonSize.small) {
      buttonPadding = AppThemeExt.of.majorScale(5 / 4);
    }
    return _prefixIcon != null
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.of.primaryColor,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: _onPressed,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppThemeExt.of.majorScale(1))),
              focusColor: Colors.blue,
              child: Container(
                  padding: EdgeInsets.all(buttonPadding), child: _prefixIcon),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.of.grayColor[4]!)),
            child: InkWell(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppThemeExt.of.majorScale(1))),
              focusColor: Colors.blue,
              child: Container(
                  padding: EdgeInsets.all(buttonPadding),
                  child: Row(
                    children: [
                      AppTextBody1Widget().setText(_buttonText!).build(context)
                    ],
                  )),
            ),
          );
  }

  Widget _square(BuildContext context) {
    double width = AppThemeExt.of.majorScale(12);
    double height = AppThemeExt.of.majorScale(12);
    double horizontalPadding = AppThemeExt.of.majorScale(3);

    if (_appButtonSize == AppButtonSize.medium) {
      width = AppThemeExt.of.majorScale(10);
      height = AppThemeExt.of.majorScale(10);
      horizontalPadding = AppThemeExt.of.majorScale(2);
    }
    if (_appButtonSize == AppButtonSize.small) {
      width = AppThemeExt.of.majorScale(8);
      height = AppThemeExt.of.majorScale(8);
      horizontalPadding = AppThemeExt.of.majorScale(1);
    }

    return SizedBox(
      width: width,
      height: height,
      child: _prefixIcon != null
          ? FilledButton(
              onPressed: _isDisabled == true ? null : _onPressed,
              style: _buttonStyle(context)?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                  (Set<MaterialState> states) =>
                      EdgeInsets.symmetric(horizontal: horizontalPadding),
                ),
              ),
              child: _prefixIcon!,
            )
          : FilledButton(
              onPressed: _isDisabled == true ? null : _onPressed,
              style: _buttonStyle(context)?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                  (Set<MaterialState> states) =>
                      EdgeInsets.symmetric(horizontal: horizontalPadding),
                ),
              ),
              child: AppTextBody1Widget()
                  .setText(_buttonText!)
                  .setColor(AppColors.of.grayColor[1])
                  .build(context),
            ),
    );
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    double horizontalPadding = AppThemeExt.of.majorScale(4);
    double verticalPadding = AppThemeExt.of.majorScale(9 / 4);
    final textColor = AppColors.of.grayColor[1];
    TextStyle? textStyle = _textStyle?.copyWith(color: textColor) ??
        AppTextStyleExt.of.textBody1m?.copyWith(color: textColor);

    if (_appButtonSize == AppButtonSize.medium) {
      horizontalPadding = AppThemeExt.of.majorScale(3);
      verticalPadding = AppThemeExt.of.majorScale(5 / 4);
      textStyle = _textStyle?.copyWith(color: textStyle?.color) ??
          AppTextStyleExt.of.textBody1m?.copyWith(color: textStyle?.color);
    }
    if (_appButtonType == AppButtonType.danger) {
      return AppButtonStyle.filledButtonDangerStyle?.copyWith(
        padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
          (Set<MaterialState> states) => EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) => textStyle,
        ),
      );
    }
    return context.theme.filledButtonTheme.style?.copyWith(
      padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
        (Set<MaterialState> states) => EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
        (Set<MaterialState> states) => textStyle,
      ),
    );
  }
}
