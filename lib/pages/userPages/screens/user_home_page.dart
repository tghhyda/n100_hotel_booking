import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n100_hotel_booking/models/room/convenient_model.dart';
import 'package:n100_hotel_booking/models/room/review_model.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/room/status_room_model.dart';
import 'package:n100_hotel_booking/models/room/type_room_model.dart';
import 'package:n100_hotel_booking/pages/userPages/widgets/room_item.dart';
import 'package:n100_hotel_booking/models/user_model.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<RoomModel> filteredRoomList = [];

  void fetchRoomList() async {
    QuerySnapshot roomSnapshot =
        await FirebaseFirestore.instance.collection('rooms').get();
    List<RoomModel> rooms = roomSnapshot.docs.map((doc) {
      String idRoom = doc['idRoom'] as String;

      Map<String, dynamic> typeRoomData =
          doc['typeRoom'] as Map<String, dynamic>;
      TypeRoomModel typeRoom = TypeRoomModel(
        typeRoomData['idTypeRoom'] as String,
        typeRoomData['nameTypeRoom'] as String,
      );

      int priceRoom = doc['price'] as int;
      int capacity = doc['capacity'] as int;

      Map<String, dynamic> statusRoomData =
          doc['statusRoom'] as Map<String, dynamic>;
      StatusRoomModel statusRoom = StatusRoomModel(
        statusRoomData['idStatus'] as String,
        statusRoomData['description'] as String,
      );

      List<dynamic> convenientsData = doc['convenients'] as List<dynamic>;
      List<ConvenientModel?> convenients =
          convenientsData.map((convenientData) {
        Map<String, dynamic> data = convenientData as Map<String, dynamic>;
        return ConvenientModel(
          data['idConvenient'] as String,
          data['nameConvenient'] as String,
        );
      }).toList();

      List<String> imageUrls = (doc['images'] as List<dynamic>).cast<String>();
      // List<ReviewModel?>? reviews = doc['reviews'] as List<ReviewModel?>?;
      String description = doc['descriptionRoom'] as String;
      return RoomModel(typeRoom, priceRoom, capacity, statusRoom, convenients,
          null, description, imageUrls,
          idRoom: idRoom);
    }).toList();
    setState(() {
      filteredRoomList = rooms;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRoomList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: filteredRoomList.length,
        itemBuilder: (context, index) {
          return RoomItem(room: filteredRoomList[index]);
        },
      ),
    );
  }
}
