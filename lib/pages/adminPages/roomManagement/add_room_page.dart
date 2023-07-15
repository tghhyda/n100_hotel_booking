import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/dropdownButton/dropdown_button_widget.dart';
import 'package:n100_hotel_booking/components/imagePicker/image_picker_widget.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/registerPage/register_controller.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import 'admin_room_controller.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key, required this.onAddRoomCallback});

  final void Function() onAddRoomCallback;

  @override
  _AddRoomPageState createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  _AddRoomPageState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController nameRoomController = TextEditingController();
  final TextEditingController descriptionRoomController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final adminRoomController = AdminRoomController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: AppColorsExt.primaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormFieldWidget(
                            controller: nameRoomController,
                            hintText: 'Name Room',
                            prefixIcon: const Icon(Icons.bed),
                            displaySuffixIcon: false,
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {},
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                            controller: descriptionRoomController,
                            hintText: 'Description Room',
                            prefixIcon: const Icon(Icons.description),
                            displaySuffixIcon: false,
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {},
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                const CircularProgressIndicator();
                                Navigator.pop(context);
                                setState(() {

                                });
                              },
                              color: Colors.white,
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                // handleUploadImage(context);
                                adminRoomController.postDetailsRoomToFireStore(
                                    context,
                                    _formkey,
                                    nameRoomController.text,
                                    descriptionRoomController.text);
                                Navigator.pop(context);
                                widget.onAddRoomCallback();
                              },
                              color: Colors.white,
                              child: const Text(
                                "Add Room",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// void handleUploadImage(BuildContext context) async {
//   setState(() {
//     showProgress = true;
//   });
//
//   if (selectedFile != null) {
//     Reference ref = FirebaseStorage.instance.ref();
//     Reference refDirImages = ref.child('avatars');
//     Reference refImageToUpload =
//         refDirImages.child("${DateTime.now().millisecondsSinceEpoch}");
//
//     try {
//       await refImageToUpload.putFile(selectedFile!);
//       imageUrl = await refImageToUpload.getDownloadURL();
//       setState(() {});
//     } catch (e) {
//       // Handle Firebase upload error
//     }
//   }
// }
//
// Future<void> _selectDate(BuildContext context) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//   );
//
//   if (picked != null && picked != _selectedBirthDate) {
//     setState(() {
//       _selectedBirthDate = picked;
//       birthdayController.text =
//           picked.toString(); // Hiển thị ngày đã chọn lên TextFormField
//     });
//   }
// }
}
