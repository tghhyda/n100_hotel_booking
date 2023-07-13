import 'package:flutter/material.dart';

typedef FormFieldChangedCallback = void Function(String value);

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController _controller;
  final String _hintText;
  final FormFieldValidator<String> _validator;
  final TextInputType? _textInputType;
  final FormFieldChangedCallback? _onChanged;
  final bool? _obscureText;
  final bool? _displaySuffixIcon;

  const TextFormFieldWidget({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    bool? obscureText,
    bool? displaySuffixIcon,
    TextInputType? textInputType,
    void Function(String)? onChanged,
  })  : _obscureText = obscureText,
        _displaySuffixIcon = displaySuffixIcon,
        _onChanged = onChanged,
        _textInputType = textInputType,
        _validator = validator,
        _hintText = hintText,
        _controller = controller,
        super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget._obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: widget._displaySuffixIcon ?? true ? IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
            widget._onChanged?.call(widget._controller.text);
          },
        ) : null,
        filled: true,
        fillColor: Colors.white,
        hintText: widget._hintText,
        enabled: true,
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: widget._validator,
      onChanged: widget._onChanged,
      keyboardType: widget._textInputType,
    );
  }
}
