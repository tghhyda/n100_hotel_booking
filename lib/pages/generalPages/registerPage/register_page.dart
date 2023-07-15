import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/dropdownButton/dropdown_button_widget.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/registerPage/register_controller.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showProgress = false;
  bool visible = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String imageUrl = '';
  bool isObscure = true;
  bool isObscure2 = true;
  File? selectedFile;
  String role = "User";
  final List<String> items = ['Male', 'Female'];
  String selectedGender = 'Male'; // Thêm biến selectedGender
  DateTime selectedBirthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final registerController = RegisterController();
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Text(
                          "Register Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            buildImagePreview(),
                            Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.camera,
                                  );

                                  if (file == null) return;

                                  setState(() {
                                    selectedFile = File(file.path);
                                    showProgress = true;
                                  });

                                  if (selectedFile != null) {
                                    try {
                                      Reference ref =
                                          FirebaseStorage.instance.ref();
                                      Reference refDirImages =
                                          ref.child('avatars');
                                      Reference refImageToUpload =
                                          refDirImages.child(
                                              "${DateTime.now().millisecondsSinceEpoch}");

                                      UploadTask uploadTask = refImageToUpload
                                          .putFile(selectedFile!);
                                      TaskSnapshot snapshot =
                                          await uploadTask.whenComplete(() {});
                                      imageUrl =
                                          await snapshot.ref.getDownloadURL();

                                      print('ImageUrl: $imageUrl');

                                      setState(() {});
                                    } catch (e) {
                                      // Handle Firebase upload error
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: TextFormFieldWidget(
                                controller: nameController,
                                hintText: "Name",
                                validator: (value) {
                                  return null;
                                },
                                displaySuffixIcon: false,
                                prefixIcon: const Icon(Icons.people),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: DropdownButtonWidget(
                                listItem: items,
                                labelText: "Gender",
                                selectedValue: selectedGender,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: TextFormFieldWidget(
                                controller: phoneController,
                                hintText: "Phone number",
                                validator: (value) {
                                  return null;
                                },
                                prefixIcon: const Icon(Icons.phone),
                                displaySuffixIcon: false,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(
                                  text: DateFormat('dd/MM/yyyy')
                                      .format(selectedBirthDate),
                                ),
                                hintText: 'Birth Date',
                                readOnly: true,
                                prefixIcon: const Icon(Icons.calendar_month),
                                displaySuffixIcon: false,
                                onTap: () => _selectDate(context),
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: addressController,
                          hintText: 'Address',
                          prefixIcon: const Icon(Icons.location_on),
                          displaySuffixIcon: false,
                          validator: (value) {
                            return null;
                          },
                          onChanged: (value) {
                            print('Email changed: $value');
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: emailController,
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          displaySuffixIcon: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                            ).hasMatch(value)) {
                              return "Please enter a valid email";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            print('Email changed: $value');
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: isObscure,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Please enter a valid password (min. 6 characters)";
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: const Icon(Icons.lock),
                          onChanged: null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: confirmPasswordController,
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Confirm password',
                          obscureText: isObscure2,
                          validator: (value) {
                            if (confirmPasswordController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: null,
                        ),
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
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                const CircularProgressIndicator();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              color: Colors.white,
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                registerController.signUp(
                                  context,
                                  _formKey,
                                  emailController.text,
                                  passwordController.text,
                                  imageUrl,
                                  nameController.text,
                                  phoneController.text,
                                  addressController.text,
                                  birthdayController.text,
                                  selectedGender,
                                  role,
                                );
                              },
                              color: Colors.white,
                              child: const Text(
                                "Register",
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedBirthDate) {
      setState(() {
        selectedBirthDate = picked;
        birthdayController.text = picked.toString();
      });
    }
  }

  Widget buildImagePreview() {
    if (selectedFile != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
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
