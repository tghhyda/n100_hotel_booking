import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_room_management_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';

class AdminRoomController {
  postDetailsRoomToFireStore(BuildContext context, GlobalKey<FormState> formKey,
      String nameRoom, String descriptionRoom) async {
    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    if (formKey.currentState!.validate()) {
      CollectionReference ref = firebaseFireStore.collection('rooms');
      ref
          .doc(nameRoom)
          .set({'nameRoom': nameRoom, 'descriptionRoom': descriptionRoom});
    }
  }
}
