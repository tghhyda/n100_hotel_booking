import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/registerPage/register_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  String imageUrl = '';
  final bool _isObscure = true;
  final bool _isObscure2 = true;
  File? selectedFile;
  var role = "User";

  Widget buildImagePreview() {
    if (selectedFile != null) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(64)),
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

  void handleUploadImage(BuildContext context) async {
    setState(() {
      showProgress = true;
    });

    if (selectedFile != null) {
      Reference ref = FirebaseStorage.instance.ref();
      Reference refDirImages = ref.child('avatars');
      Reference refImageToUpload =
          refDirImages.child("${DateTime.now().millisecondsSinceEpoch}moinhat");

      try {
        await refImageToUpload.putFile(selectedFile!);
        imageUrl = await refImageToUpload.getDownloadURL();
        setState(() {});
      } catch (e) {
        // Handle Firebase upload error
      }
    }
  }

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
                    key: _formkey,
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
                          height: 30,
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
                                        source: ImageSource.camera);

                                    if (file == null) return;

                                    setState(() {
                                      selectedFile = File(file.path);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                            controller: emailController,
                            hintText: 'Email',
                            // obscureText: false,
                            displaySuffixIcon: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              // Xử lý sự kiện khi giá trị thay đổi
                              print('Email changed: $value');
                              // Các xử lý khác...
                            },
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: _isObscure,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
                            onChanged: null),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                            controller: confirmPasswordController,
                            hintText: 'Confirm password',
                            obscureText: _isObscure2,
                            validator: (value) {
                              if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
                            onChanged: null),
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
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                handleUploadImage(context);
                                registerController!.signUp(
                                    context,
                                    _formkey,
                                    emailController.text,
                                    passwordController.text,
                                    imageUrl,
                                    role);
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
}
