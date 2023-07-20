import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/constants/app_url_ext.dart';
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

  void searchRooms(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        fetchRoomList();
      });
    } else {
      FirebaseFirestore.instance
          .collection('rooms')
          .where('idRoom', isGreaterThanOrEqualTo: keyword)
          .where('idRoom', isLessThanOrEqualTo: keyword + '\uf8ff')
          .get()
          .then((QuerySnapshot querySnapshot) {
        List<RoomModel> filteredRooms = querySnapshot.docs.map((doc) {
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

          List<String> imageUrls =
              (doc['images'] as List<dynamic>).cast<String>();
          // List<ReviewModel?>? reviews = doc['reviews'] as List<ReviewModel?>?;
          String description = doc['descriptionRoom'] as String;
          return RoomModel(typeRoom, priceRoom, capacity, statusRoom,
              convenients, null, description, imageUrls,
              idRoom: idRoom);
        }).toList();
        setState(() {
          filteredRoomList = filteredRooms;
        });
      }).catchError((error) {
        // Handle any potential errors during the search
        print("Error searching rooms: $error");
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
    return Container(
      color: AppColorsExt.backgroundColor,
      child: Column(
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
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        labelText: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
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
                return Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.withOpacity(0.2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              room.images!.isNotEmpty
                                  ? room.images![0] ??
                                      AppUrlExt.defaultRoomImage
                                  : AppUrlExt.defaultRoomImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                room.idRoom,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Status: ${room.statusRoom.description}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Price: ${room.priceRoom.toString()} VNĐ',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _deleteRoom(room);
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
