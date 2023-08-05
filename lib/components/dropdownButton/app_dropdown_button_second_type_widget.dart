import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropdownButtonSecondTypeWidget {
  late final List<String>? listItem;
  final String? labelText;
  String? selectedValue;
  void Function(String?)? onChanged;

  AppDropdownButtonSecondTypeWidget(
      {required this.listItem,
      required this.labelText,
      required this.selectedValue,
      required this.onChanged});

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
                labelText ?? '',
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
        items: listItem
            ?.map((String item) => DropdownMenuItem<String>(
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
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
