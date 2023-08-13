import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/base_model.dart';


class AdminRoomController {
  postDetailsRoomToFireStore(
    BuildContext context,
    GlobalKey<FormState> formKey,
    String idRoom,
    TypeRoomModel typeRoom,
    List<ConvenientModel> convenients,
    String descriptionRoom,
    int price,
    int capacity,
    StatusRoomModel status,
  ) async {
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
        'statusRoom': {
          'idStatus': status.idStatus,
          'description': status.description
        },
        'price': price,
        'capacity': capacity,
        'convenients': convenientData,
        'descriptionRoom': descriptionRoom,
        'feedbacks': []
      };
      ref.doc(idRoom).set(roomData);
    }
  }

  void updateDetailsRoomInFireStore(
    BuildContext context,
    String idRoom,
    TypeRoomModel typeRoom,
    List<ConvenientModel?> convenients,
    String descriptionRoom,
    int price,
    int capacity,
    StatusRoomModel status,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('rooms');

    List<Map<dynamic, dynamic>> convenientData = convenients.map((convenient) {
      if (convenient == null) return {}; // Trường hợp convenient là null
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
      'statusRoom': {
        'idStatus': status.idStatus,
        'description': status.description,
      },
      'price': price,
      'capacity': capacity,
      'convenients': convenientData,
      'descriptionRoom': descriptionRoom,
    };

    await ref.doc(idRoom).update(roomData);
  }
}
