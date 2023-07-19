import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room/convenient_model.dart';
import 'package:n100_hotel_booking/models/room/review_model.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/room/status_room_model.dart';
import 'package:n100_hotel_booking/models/room/type_room_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/add_room_page.dart';

class AdminRoomManagementPage extends StatefulWidget {
  const AdminRoomManagementPage({Key? key}) : super(key: key);

  @override
  State<AdminRoomManagementPage> createState() =>
      _AdminRoomManagementPageState();
}

class _AdminRoomManagementPageState extends State<AdminRoomManagementPage> {
  TextEditingController searchController = TextEditingController();

  List<RoomModel> filteredRoomList = [];

  void refreshRoomList() {
    fetchRoomList();
  }

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

      // List<ReviewModel?>? reviews = doc['reviews'] as List<ReviewModel?>?;
      String description = doc['descriptionRoom'] as String;
      return RoomModel(typeRoom, priceRoom, capacity, statusRoom, convenients,
          null, description,
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

  void searchRooms(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        filteredRoomList = [];
      });
    } else {
      FirebaseFirestore.instance
          .collection('rooms')
          .where('name', isGreaterThanOrEqualTo: keyword)
          .where('name', isLessThan: '${keyword}z')
          .get()
          .then((QuerySnapshot querySnapshot) {
        List<RoomModel> filteredRooms = querySnapshot.docs.map((doc) {
          String idRoom = doc['idRoom'] as String;
          TypeRoomModel typeRoom = doc['typeRoom'] as TypeRoomModel;
          int priceRoom = doc['price'] as int;
          int capacity = doc['capacity'] as int;
          StatusRoomModel statusRoom = doc['statusRoom'] as StatusRoomModel;

          List<dynamic> convenientsData = doc['convenients'] as List<dynamic>;
          List<ConvenientModel?> convenients =
              convenientsData.map((convenientData) {
            Map<String, dynamic> data = convenientData as Map<String, dynamic>;
            return ConvenientModel(
              data['idConvenient'] as String,
              data['nameConvenient'] as String,
            );
          }).toList();

          List<ReviewModel?>? reviews = doc['reviews'] as List<ReviewModel?>?;

          String description = doc['description'] as String;
          return RoomModel(typeRoom, priceRoom, capacity, statusRoom,
              convenients, reviews, description,
              idRoom: idRoom);
        }).toList();
        setState(() {
          filteredRoomList = filteredRooms;
        });
      });
    }
  }

  void _deleteRoom(RoomModel room) {
    FirebaseFirestore.instance
        .collection('rooms')
        .where('idRoom', isEqualTo: room.idRoom)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
      fetchRoomList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      searchRooms(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddRoomPage(
                            onAddRoomCallback: refreshRoomList,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredRoomList.length,
            itemBuilder: (context, index) {
              RoomModel room = filteredRoomList[index];
              return Card(
                color: Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.withOpacity(0.2),
                        // Replace with your image widget
                        // child: Image.network(
                        //   'https://example.com/image.jpg',
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.idRoom,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(room.description),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteRoom(room);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
