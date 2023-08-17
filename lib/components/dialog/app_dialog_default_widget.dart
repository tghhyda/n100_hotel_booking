part of 'app_dialog_base_builder.dart';

class AppDefaultDialogWidget extends AppDialogBaseBuilder {
  @override
  AppDialogBaseBuilder setTitle(String? title) {
    _title = title;
    return super.setTitle(title);
  }

  @override
  AppDialogBaseBuilder setContent(String? content) {
    _content = content;
    return super.setContent(content);
  }

  @override
  AppDialogBaseBuilder setIcon(Widget? icon) {
    _icon = icon;
    return super.setIcon(icon);
  }

  @override
  AppDialogBaseBuilder setPositiveText(String? positiveText) {
    _positiveText = positiveText;
    return super.setPositiveText(positiveText);
  }

  @override
  AppDialogBaseBuilder setNegativeText(String? negativeText) {
    _negativeText = negativeText;
    return super.setNegativeText(negativeText);
  }

  @override
  AppDialogBaseBuilder setOnPositive(void Function()? onPositive) {
    _onPositive = onPositive;
    return super.setOnPositive(onPositive);
  }

  @override
  AppDialogBaseBuilder setOnNegative(void Function()? onNegative) {
    _onNegative = onNegative;
    return super.setOnPositive(onNegative);
  }

  @override
  AppDialogBaseBuilder setAppDialogType(AppDialogType? type) {
    _appDialogType = type;
    return super.setAppDialogType(type);
  }

  @override
  AppDialogBaseBuilder setTextField(Widget? textField) {
    _textField = textField;
    return super.setTextField(textField);
  }

  @override
  AppDialogBaseBuilder setAppDialogButtonType(
      AppDialogButtonType? appDialogButtonType) {
    _appDialogButtonType = appDialogButtonType;
    return super.setAppDialogButtonType(appDialogButtonType);
  }

  @override
  AppDialogBaseBuilder setIsHaveCloseIcon(bool? isHaveCloseIcon) {
    _isHaveCloseIcon = isHaveCloseIcon;
    return super.setIsHaveCloseIcon(isHaveCloseIcon);
  }

  @override
  AppDialogBaseBuilder buildDialog(BuildContext context) {
    if (_appDialogType == AppDialogType.success) {
      setIcon(Image.asset(
        'assets/statusDialog/success_status_icon.png',
        height: 30,
        width: 30,
      ));
    }
    if (_appDialogType == AppDialogType.error) {
      setIcon(Image.asset(
        'assets/statusDialog/error_status_icon.png',
        height: 30,
        width: 30,
      ));
    }
    if (_appDialogType == AppDialogType.confirm) {
      setIcon(Image.asset(
        'assets/statusDialog/confirm_status_icon.png',
        height: 30,
        width: 30,
      ));
    }
    _dialog = Dialog(
      insetPadding: EdgeInsets.all(AppThemeExt.of.majorScale(6)),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.of.grayColor[1],
              borderRadius: BorderRadius.circular(AppThemeExt.of.majorScale(3)),
            ),
            padding: EdgeInsets.all(AppThemeExt.of.majorScale(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppThemeExt.of.majorScale(2)),
                if (_icon != null) _icon!,
                if (_title != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppThemeExt.of.majorScale(3)),
                    child: AppTextHeading3Widget()
                        .setText(_title)
                        .setTextAlign(TextAlign.center)
                        .build(context),
                  ),
                if (_content != null)
                  AppTextBody1Widget()
                      .setText(_content)
                      .setTextStyle(AppTextStyleExt.of.textBody1r)
                      .setTextAlign(TextAlign.center)
                      .build(context),
                SizedBox(height: AppThemeExt.of.majorScale(6)),
                if (_textField != null) _textField!,
                if (_textField != null)
                  SizedBox(height: AppThemeExt.of.majorScale(6)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_negativeText != null)
                      Expanded(
                        child: AppOutlinedButtonWidget()
                            .setButtonText(_negativeText)
                            .setAppButtonSize(AppButtonSize.large)
                            .setOnPressed(() {
                          Get.back();
                          _onNegative?.call();
                        }).build(context),
                      ),
                    if (_negativeText != null)
                      SizedBox(width: AppThemeExt.of.majorScale(3)),
                    if (_positiveText != null)
                      _appDialogButtonType == AppDialogButtonType.danger
                          ? Expanded(
                              child: AppFilledButtonWidget()
                                  .setButtonText(_positiveText)
                                  .setAppButtonSize(AppButtonSize.large)
                                  .setAppButtonType(AppButtonType.danger)
                                  .setOnPressed(() {
                                Get.back();
                                _onPositive?.call();
                              }).build(context),
                            )
                          : Expanded(
                              child: AppFilledButtonWidget()
                                  .setButtonText(_positiveText)
                                  .setAppButtonSize(AppButtonSize.large)
                                  .setOnPressed(() {
                                Get.back();
                                _onPositive?.call();
                              }).build(context),
                            ),
                  ],
                ),
              ],
            ),
          ),
          _isHaveCloseIcon == true
              ? Positioned(
                  right: 0.0,
                  child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              : const SizedBox()
        ],
      ),
    );
    return this;
  }
}
