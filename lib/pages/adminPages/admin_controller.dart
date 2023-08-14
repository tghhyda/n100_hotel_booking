import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class AdminController extends GetxController {
  Future<List<RoomModel>> fetchRoomList() async {
    try {
      QuerySnapshot roomSnapshot =
          await FirebaseFirestore.instance.collection('rooms').get();

      List<RoomModel> rooms = roomSnapshot.docs.map((doc) {
        RoomModel room = RoomModel.fromJson(doc.data() as Map<String, dynamic>);
        return room;
      }).toList();
      return rooms;
    } catch (e) {
      print("Error fetching room list: $e");
      return [];
    }
  }

  Future<List<StatusRoomModel>> fetchStatusList() async {
    try {
      QuerySnapshot statusSnapshot =
          await FirebaseFirestore.instance.collection('statusRooms').get();
      List<StatusRoomModel> statusList = statusSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return StatusRoomModel.fromJson(data);
      }).toList();

      return statusList;
    } catch (e) {
      print("Error fetching status list: $e");
      return [];
    }
  }

  Future<List<ConvenientModel>> fetchConvenientList() async {
    try {
      QuerySnapshot convenientSnapshot =
          await FirebaseFirestore.instance.collection('convenients').get();
      List<ConvenientModel> convenientList = convenientSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ConvenientModel.fromJson(data);
      }).toList();

      return convenientList;
    } catch (e) {
      print("Error fetching convenient list: $e");
      return [];
    }
  }

  Future<List<TypeRoomModel>> fetchTypeRoomList() async {
    try {
      QuerySnapshot typeRoomSnapshot =
          await FirebaseFirestore.instance.collection('typeRooms').get();
      List<TypeRoomModel> typeRoomList = typeRoomSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TypeRoomModel.fromJson(data);
      }).toList();

      return typeRoomList;
    } catch (e) {
      print("Error fetching convenient list: $e");
      return [];
    }
  }

  @override
  void onInit() {
    fetchRoomList();
    fetchConvenientList();
    fetchStatusList();
    fetchTypeRoomList();
  }
}
