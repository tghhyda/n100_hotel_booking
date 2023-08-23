import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_controller.dart';

class RegisterController {
  void signUp(
      BuildContext context,
      GlobalKey<FormState> formKey,
      String password,
      UserModel userModel
      ) async {
    const CircularProgressIndicator();
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userModel.email, password: password)
          .then((value) => {
                postDetailsToFireStore(
                    context, userModel)
              })
          .catchError((e) {
            print(e);
      });
    }
  }

  postDetailsToFireStore(BuildContext context, UserModel userModel) async {
    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFireStore.collection('users');
    ref.doc(userModel.email).set(userModel.toJson());
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
