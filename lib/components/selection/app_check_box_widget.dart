import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class AppCheckBoxWidget{
  bool? _value;
  String? _title;
  void Function(bool?)? _onChanged;
  bool? _isDisabled;

  AppCheckBoxWidget setValue(bool value){
    _value = value;
    return this;
  }

  AppCheckBoxWidget setTitle(String title){
    _title = title;
    return this;
  }

  AppCheckBoxWidget setOnChanged(void Function(bool?) onChanged){
    _onChanged = onChanged;
    return this;
  }

  Widget build(BuildContext context){
    return Row(
      children: [
        Checkbox(
          value: _value ?? false,
          activeColor: _activeColor,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) => AppColors.of.grayColor[3],
          ),
          side: BorderSide(color: _sideColor),
          onChanged: _isDisabled == true
              ? null
              : (value) {
            _value = value;
            _onChanged?.call(value);
          },
        ),
        if (_title != null)
          AppTextBody1Widget()
              .setText(_title)
              .setTextStyle(
              AppTextStyleExt.of.textBody1r?.copyWith(color: _labelColor))
              .build(context)
      ],
    );
  }

  Color? get _activeColor => _isDisabled == true
      ? AppColors.of.grayColor[4]
      : AppColors.of.yellowColor[6];

  Color get _sideColor => _isDisabled == true
      ? AppColors.of.grayColor[3]!
      : AppColors.of.yellowColor[7]!;
  Color? get _labelColor =>
      _isDisabled == true ? AppColors.of.grayColor[5] : AppColors.of.grayColor;
}