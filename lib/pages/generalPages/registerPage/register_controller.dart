import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';

class RegisterController {
  void signUp(BuildContext context, GlobalKey<FormState> formKey, String email,
      String password,String imageUrl, String role) async {
    const CircularProgressIndicator();
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFireStore(context, email, imageUrl, role)})
          .catchError((e) {});
    }
  }

  postDetailsToFireStore(
      BuildContext context, String email, String imageUrl, String role) async {
    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = firebaseFireStore.collection('users');
    ref.doc(email).set({'email': email, 'imageUrl': imageUrl, 'role': role});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
