import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/selection/app_check_box_widget.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_home.dart';
import 'package:n100_hotel_booking/pages/generalPages/components/divider_widget.dart';
import 'package:n100_hotel_booking/pages/generalPages/components/square_tile_widget.dart';
import 'package:n100_hotel_booking/pages/generalPages/forgotPasswordPage/forgot_password_controller.dart';
import 'package:n100_hotel_booking/pages/generalPages/registerPage/register_page.dart';
import 'package:n100_hotel_booking/pages/userPages/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_page.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isInvalid = false;
  final RxBool isObscure = true.obs;
  bool visible = false;
  RxBool keepLoggedIn = false.obs;
  var auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();

    _autoFillUserCredentials();
    _autoFillKeepLoggedIn();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Lưu thông tin đăng nhập bằng Google vào Firestore
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.email);
        await userDoc.set({
          'email': user.email,
          'role': 'User', // Lưu vai trò là "user"
          'phoneNumber': '0101010101',
          'nameUser': user.displayName,
          'imageUrl': user.photoURL,
          'gender': 'Male',
          'birthday': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
          'address': 'Somewhere'
        });
        route(Get.context!);
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  void _autoFillKeepLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? temp = prefs.getBool('keepLoggedIn');

    if (keepLoggedIn != null) {
      keepLoggedIn.value = temp ?? false;
    }
  }

  void toggleKeepLoggedIn(bool value) async {
    keepLoggedIn.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('keepLoggedIn', value);
  }

  void _autoFillUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    String? password = prefs.getString('userPassword');

    if (email != null && keepLoggedIn.value == true) {
      emailController.text = email;
    }

    if (password != null && keepLoggedIn.value == true) {
      passwordController.text = password;
    }
  }

  void route(BuildContext context) async {
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
              builder: (context) => UserHome(),
            ),
          );
        }
      } else {
        print('Document does not exist in the database');
      }
    }
  }

  Future<String> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Lưu thông tin đăng nhập
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userEmail', email);
        prefs.setString('userPassword', password);
      }

      route(Get.context ?? context);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      isInvalid = true;
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'An error occurred.';
    }
  }

  Future<UserCredential?> autoSignIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    String? password = prefs.getString('userPassword');

    if (email != null && password != null) {
      String signInResult =
          await signIn(Get.context ?? context, email, password);
      if (signInResult == 'Success') {
        return FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    }
    return null;
  }
}
