import 'package:flutter/material.dart';

class AppDropdownFutureWidget<T> extends StatelessWidget {
  final String hint;
  final Future<List<T>> future;
  final String Function(T item) displayText;
  final Function(T? value)? onChanged;
  final T? selectedItem;

  const AppDropdownFutureWidget({super.key,required this.hint,
    required this.future,
    required this.displayText,
    this.onChanged, required this.selectedItem,});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              hint: Text(hint),
              items: snapshot.data!.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(displayText(item)),
                );
              }).toList(),
              value: selectedItem,
              onChanged: onChanged,
            ),
          );
        } else {
          return const Text('No data available.');
        }
      },
    );
  }
}