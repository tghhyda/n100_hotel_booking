import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n100_hotel_booking/models/room_model.dart';
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
      String name = doc['nameRoom'] as String;
      String description = doc['descriptionRoom'] as String;
      return RoomModel(name: name, description: description);
    }).toList();
    setState(() {
      filteredRoomList = rooms;
    });

    print(filteredRoomList);
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
