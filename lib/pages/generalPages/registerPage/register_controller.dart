import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';

class RegisterController {
  void signUp(
      BuildContext context,
      GlobalKey<FormState> formKey,
      String email,
      String password,
      String imageUrl,
      String name,
      String phone,
      String address,
      String birthday,
      String role) async {
    const CircularProgressIndicator();
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFireStore(
                    context, email, imageUrl, name, phone, address, birthday, role)
              })
          .catchError((e) {});
    }
  }

  postDetailsToFireStore(BuildContext context, String email, String imageUrl,
      String name, String phone, String address, String birthday, String role) async {
    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFireStore.collection('users');
    ref.doc(email).set({
      'email': email,
      'imageUrl': imageUrl,
      'name': name,
      'phone': phone,
      'address': address,
      'birthday': birthday,
      'role': role
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
