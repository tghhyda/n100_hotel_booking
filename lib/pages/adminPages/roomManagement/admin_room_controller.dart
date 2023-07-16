import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room/convenient_model.dart';
import 'package:n100_hotel_booking/models/room/type_room_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_room_management_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';

class AdminRoomController {
  postDetailsRoomToFireStore(
      BuildContext context,
      GlobalKey<FormState> formKey,
      String idRoom,
      TypeRoomModel typeRoom,
      List<ConvenientModel> convenients,
      String descriptionRoom) async {
    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    if (formKey.currentState!.validate()) {
      CollectionReference ref = firebaseFireStore.collection('rooms');
      List<Map<String, dynamic>> convenientData = convenients.map((convenient) {
        return {
          'idConvenient': convenient.idConvenient,
          'nameConvenient': convenient.nameConvenient,
        };
      }).toList();
      Map<String, dynamic> roomData = {
        'idRoom': idRoom,
        'typeRoom': {
          'idTypeRoom': typeRoom.idTypeRoom,
          'nameTypeRoom': typeRoom.nameTypeRoom,
        },
        'convenients': convenientData,
        'descriptionRoom': descriptionRoom,
        'feedbacks': null
      };
      ref.doc(idRoom).set(roomData);
    }
  }
}
