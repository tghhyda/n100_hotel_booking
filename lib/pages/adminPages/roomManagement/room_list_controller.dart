import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';

class RoomListController extends GetxController {
  RxList<RoomModel> roomList = <RoomModel>[].obs;
  var isLoading = true.obs;


  void updateRoomList(List<RoomModel> updatedList) {
    roomList.assignAll(updatedList);
  }

// ... other methods if needed ...
}
