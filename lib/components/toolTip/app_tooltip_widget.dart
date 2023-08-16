part of 'app_tooltip_base_builder.dart';

class AppTooltipWidget extends AppTooltipBaseBuilder {
  @override
  AppTooltipBaseBuilder setIcon(Widget icon) {
    _icon = icon;
    return this;
  }

  @override
  AppTooltipWidget setBackgroundColor(Color backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppTooltipWidget setText(String text) {
    _text = text;
    return this;
  }

  @override
  AppTooltipWidget setPreferredDirection(AxisDirection preferredDirection) {
    _preferredDirection = preferredDirection;
    return this;
  }

  @override
  AppTooltipWidget setTextColor(Color textColor) {
    _textColor = textColor;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      isModal: true,
      tailBaseWidth: AppThemeExt.of.majorScale(2),
      tailLength: AppThemeExt.of.majorScale(1),
      backgroundColor: _backgroundColor ?? AppColors.of.grayColor[8],
      triggerMode: TooltipTriggerMode.tap,
      preferredDirection: _preferredDirection ?? AxisDirection.down,
      content: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppThemeExt.of.majorPaddingScale(3),
          horizontal: AppThemeExt.of.majorPaddingScale(10 / 4),
        ),
        child: AppTextBody1Widget()
            .setColor(_textColor ?? AppColors.of.whiteColor)
            .setText(_text)
            .build(context),
      ),
      child: Material(child: _icon),
    );
  }
}
