import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';

part 'app_date_range_picker_widget.dart';

abstract class AppDateTimePickerBaseBuilder {
  late Rx<DateTimeRange>? _selectedDates;
  TextEditingController? _textController;
  void Function(String)? _onChanged;

  AppDateTimePickerBaseBuilder setSelectedDates(Rx<DateTimeRange> selectedDates);

  AppDateTimePickerBaseBuilder setTextController(
      TextEditingController textController);

  AppDateTimePickerBaseBuilder setOnChanged(void Function(String) onChanged);

  Widget build(BuildContext context);
}
