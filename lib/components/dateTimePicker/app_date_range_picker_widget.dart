part of 'app_date_time_picker_base_builder.dart';

class AppDateRangePickerWidget extends AppDateTimePickerBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: AppTextFormFieldWidget()
            .setController(_textController!)
            .setPrefixIcon(const Icon(Icons.date_range))
            .setHintText("Select check-in and check-out date")
            .setIsReadOnly(true)
            .setOnChanged((p0) {
      _onChanged?.call(p0);
    }).setOnTap(() async {
      final DateTimeRange? dateTimeRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000));
      if (dateTimeRange != null) {
        _selectedDates?.value = dateTimeRange;
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String startDate = formatter.format(_selectedDates!.value.start);
        final String endDate = formatter.format(_selectedDates!.value.end);
        _textController?.text = "$startDate - $endDate";
      }
    }).build(context));
  }

  @override
  AppDateTimePickerBaseBuilder setSelectedDates(Rx<DateTimeRange> selectedDates) {
    _selectedDates = selectedDates;
    return this;
  }

  @override
  AppDateTimePickerBaseBuilder setTextController(
      TextEditingController textController) {
    _textController = textController;
    return this;
  }

  @override
  AppDateTimePickerBaseBuilder setOnChanged(
      void Function(String p1) onChanged) {
    _onChanged = onChanged;
    return this;
  }
}
