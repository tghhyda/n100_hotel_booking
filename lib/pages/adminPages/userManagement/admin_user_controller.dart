import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class AdminUserController {
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
    Get.back();
  }
}
