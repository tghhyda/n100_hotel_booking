import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_home.dart';
import 'package:n100_hotel_booking/pages/generalPages/registerPage/register_page.dart';
import 'package:n100_hotel_booking/pages/userPages/user_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final RxBool _isObscure = true.obs;
  bool visible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLogin = false.obs;
  var auth = FirebaseAuth.instance;

  void checkIfLogin() async{
    auth.authStateChanges().listen((User? user) {
      if(user != null && mounted){
        isLogin.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: AppColorsExt.backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColorsExt.textColor,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextFormFieldWidget()
                            .setController(emailController)
                            .setHintText("Email")
                            .setPrefixIcon(const Icon(Icons.email))
                            .setAutoValidateMode(
                                AutovalidateMode.onUserInteraction)
                            .setValidator((value) {
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
                            })
                            .setInputType(TextInputType.emailAddress)
                            .build(context),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => AppTextFormFieldWidget()
                              .setController(passwordController)
                              .setHintText("Password")
                              .setPrefixIcon(const Icon(Icons.lock))
                              .setDisplaySuffixIcon(true)
                              .setObscureText(_isObscure.value)
                              .setOnTapSuffixIcon(() {
                                _isObscure.value = !_isObscure.value;
                              })
                              .setValidator((value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                              })
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .build(context),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            elevation: 5.0,
                            height: 40,
                            onPressed: () {
                              setState(() {
                                visible = true;
                              });
                              signIn(emailController.text,
                                  passwordController.text);
                            },
                            color: AppColorsExt.buttonColor,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Visibility(
                        //     maintainSize: true,
                        //     maintainAnimation: true,
                        //     maintainState: true,
                        //     visible: visible,
                        //     child: const CircularProgressIndicator(
                        //       color: Colors.white,
                        //     )),
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

  void route() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);

      if (documentSnapshot.exists) {
        String role = documentSnapshot.get('role');

        if (role == "Admin") {
          Navigator.pushReplacement(
            Get.context ?? context,
            MaterialPageRoute(
              builder: (context) => const AdminHome(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            Get.context ?? context,
            MaterialPageRoute(
              builder: (context) => const UserHome(),
            ),
          );
        }
      } else {
        print('Document does not exist in the database');
      }
    }
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
