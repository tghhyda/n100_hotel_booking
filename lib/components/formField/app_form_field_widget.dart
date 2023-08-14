import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class AppFormFieldWidget extends StatelessWidget {
  late final String? _labelText;
  late final Widget? _descriptionWidget;
  late final bool? _isRequired;
  late final Widget _child;

  AppFormFieldWidget({
    super.key,
    required String? labelText,
    Widget? descriptionWidget,
    required bool? isRequired,
    required Widget child,
  }) {
    _labelText = labelText;
    _descriptionWidget = descriptionWidget;
    _isRequired = isRequired;
    _child = child;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelTextWidget(context),
        if (_descriptionWidget != null) _descriptionTextWidget(context),
        _child,
      ],
    );
  }

  @protected
  Widget _labelTextWidget(BuildContext context) {
    String label = _labelText ?? '';

    return Column(
      children: [
        if (_labelText != null)
          RichText(
            text: TextSpan(
              text: label,
              style: AppTextStyleExt.of.textBody1s,
              children: [
                if (_isRequired ?? false)
                  TextSpan(
                    text: '*',
                    style:  AppTextStyleExt.of.textBody1s?.copyWith(
                      color: AppColors.of.redColor[5],
                    ),
                  ),
              ],
            ),
          ),
        if (_labelText != null)
          SizedBox(
            height: AppThemeExt.of.majorScale(1),
          ),
      ],
    );
  }

  @protected
  Widget _descriptionTextWidget(BuildContext context) {
    return Column(
      children: [
        _descriptionWidget!,
        SizedBox(
          height: AppThemeExt.of.majorScale(1),
        ),
      ],
    );
  }
}
