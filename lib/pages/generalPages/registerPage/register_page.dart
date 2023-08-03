import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/dropdownButton/dropdown_button_widget.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/registerPage/register_controller.dart';
import 'package:get/get.dart';

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
  RxBool isObscure = true.obs;
  RxBool isObscure2 = true.obs;
  File? selectedFile;
  String role = "User";
  final List<String> items = ['Male', 'Female'];
  String selectedGender = 'Male';
  DateTime selectedBirthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final registerController = RegisterController();
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: const Text("Fill Your Profile"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
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

                                      setState(() {});
                                    } catch (e) {
                                      // Handle Firebase upload error
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: AppColorsExt.primaryColor,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: AppTextFormFieldWidget()
                                    .setController(nameController)
                                    .setHintText("Name")
                                    .setPrefixIcon(const Icon(Icons.people))
                                    .setAutoValidateMode(
                                        AutovalidateMode.onUserInteraction)
                                    .setValidator((value) {
                              if (value!.isEmpty) {
                                return "Name cannot be empty";
                              } else {
                                return null;
                              }
                            }).build(context)),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: AppTextFormFieldWidget()
                                  .setController(phoneController)
                                  .setAutoValidateMode(
                                      AutovalidateMode.onUserInteraction)
                                  .setPrefixIcon(const Icon(Icons.phone))
                                  .setHintText("Phone Number")
                                  .setValidator((value) {
                                if (value?.length != 10) {
                                  return "Must be equal to 10 char";
                                }
                                return null;
                              }).build(context),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: AppTextFormFieldWidget()
                                    .setController(
                                      TextEditingController(
                                        text: DateFormat('dd/MM/yyyy')
                                            .format(selectedBirthDate),
                                      ),
                                    )
                                    .setDisplaySuffixIcon(false)
                                    .setIsReadOnly(true)
                                    .setPrefixIcon(
                                        const Icon(Icons.calendar_month))
                                    .setOnTap(() {
                              _selectDate(context);
                            }).build(context)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextFormFieldWidget()
                            .setHintText("Address")
                            .setController(addressController)
                            .setPrefixIcon(const Icon(Icons.location_on))
                            .setDisplaySuffixIcon(false)
                            .setAutoValidateMode(
                                AutovalidateMode.onUserInteraction)
                            .setValidator((value) {
                          if (value!.isEmpty) {
                            return "Address cannot be empty";
                          } else {
                            return null;
                          }
                        }).build(context),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextFormFieldWidget()
                            .setController(emailController)
                            .setAutoValidateMode(
                                AutovalidateMode.onUserInteraction)
                            .setHintText("Email")
                            .setValidator((value) {
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
                            })
                            .setDisplaySuffixIcon(false)
                            .setPrefixIcon(const Icon(Icons.email))
                            .build(context),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => AppTextFormFieldWidget()
                              .setController(passwordController)
                              .setHintText('Password')
                              .setObscureText(isObscure.value)
                              .setOnTapSuffixIcon(() {
                                isObscure.value = !isObscure.value;
                              })
                              .setValidator((value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return "Please enter a valid password (min. 6 characters)";
                                } else {
                                  return null;
                                }
                              })
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setPrefixIcon(const Icon(Icons.lock))
                              .setDisplaySuffixIcon(true)
                              .build(context),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => AppTextFormFieldWidget()
                              .setController(confirmPasswordController)
                              .setHintText('Confirm Password')
                              .setObscureText(isObscure2.value)
                              .setOnTapSuffixIcon(() {
                                isObscure2.value = !isObscure2.value;
                              })
                              .setValidator((value) {
                                if (confirmPasswordController.text !=
                                    passwordController.text) {
                                  return "Password did not match";
                                } else {
                                  return null;
                                }
                              })
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setPrefixIcon(const Icon(Icons.lock))
                              .setDisplaySuffixIcon(true)
                              .build(context),
                        ),
                        const SizedBox(
                          height: 20,
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
          border: Border.all(),
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
      return const SizedBox(
        height: 128,
        width: 128,
        child: CircleAvatar(
          backgroundImage:
              AssetImage('assets/defaultImage/user_default_avatar.png'),
        ),
      );
    }
  }
}
