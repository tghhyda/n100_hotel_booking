import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';

class EditRoomPage extends GetView<AdminController> {
  EditRoomPage({super.key});

  RoomModel roomModel = Get.arguments;

  TextEditingController priceController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set the initial values for the controllers
    priceController.text = roomModel.priceRoom.toString();
    bedsController.text = roomModel.beds.toString();
    capacityController.text = roomModel.capacity.toString();
    quantityController.text = roomModel.quantity.toString();
    areaController.text = roomModel.area.toString();
    descriptionController.text = roomModel.description;

    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: Text('Edit Room ${roomModel.typeRoom.nameTypeRoom}'),
        backgroundColor: AppColorsExt.backgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // You can add your form fields here for editing the room details
              // For example:
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: bedsController,
                decoration: InputDecoration(labelText: 'Number of Beds'),
                keyboardType: TextInputType.number,
              ),
              // Add other form fields similarly

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // Call a method to update the room details in the database
                  // For example:
                  updateRoomDetails();
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateRoomDetails() {
    // You can implement the logic to update the room details here
    // For example, you can use your controller's method to update the room in the database
    // and then show a snackbar or navigate back to the previous page.
  }
}
