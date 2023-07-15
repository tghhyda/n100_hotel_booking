import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room_model.dart';
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
          String name = doc['name'] as String;
          String description = doc['description'] as String;
          return RoomModel(name: name, description: description);
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
        .where('nameRoom', isEqualTo: room.name)
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddRoomPage(),
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
                              room.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
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
