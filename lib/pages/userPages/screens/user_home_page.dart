import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n100_hotel_booking/models/room/convenient_model.dart';
import 'package:n100_hotel_booking/models/room/review_model.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/room/type_room_model.dart';
import 'package:n100_hotel_booking/pages/userPages/widgets/room_item.dart';

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
      TypeRoomModel typeRoom = doc['typeRoom'] as TypeRoomModel;
      int priceRoom = doc['price'] as int;
      int capacity = doc['capacity'] as int;
      String statusRoom = doc['statusRoom'] as String;
      List<ConvenientModel?>? convenients =
          doc['convenients'] as List<ConvenientModel?>?;
      List<ReviewModel?>? reviews = doc['reviews'] as List<ReviewModel?>?;
      String description = doc['description'] as String;
      return RoomModel(typeRoom, priceRoom, capacity, statusRoom, convenients,
          reviews, description,
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
