import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final File? selectedFile;

  const ImagePreviewWidget({Key? key, this.selectedFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedFile != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(64),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(64),
          child: Image.file(
            selectedFile!,
            width: 128,
            height: 128,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 64,
        backgroundImage: NetworkImage(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDHdhmg41bLtbVhtPvxaHhDCqzJhAewA-TrBQ4Y4k&s',
        ),
      );
    }
  }
}
