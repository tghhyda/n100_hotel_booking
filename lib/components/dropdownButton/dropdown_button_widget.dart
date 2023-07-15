import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget(
      {Key? key,
      required this.listItem,
      required this.labelText,
      this.selectedValue})
      : super(key: key);

  final List<String> listItem;
  final String labelText;
  final String? selectedValue;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  late String selectedValue; // Thay đổi kiểu dữ liệu của selectedValue

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue ??
        'Male'; // Khởi tạo selectedValue từ thuộc tính widget.selectedValue
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.transgender,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.labelText ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.listItem
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value ?? 'Male';
          });
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white,
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
