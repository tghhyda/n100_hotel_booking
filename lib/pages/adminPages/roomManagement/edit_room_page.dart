import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'admin_room_controller.dart';

class EditRoomPage extends StatefulWidget {
  final RoomModel room;

  const EditRoomPage({Key? key, required this.room}) : super(key: key);

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final adminRoomController = AdminRoomController();

  TextEditingController nameRoomController = TextEditingController();
  TextEditingController descriptionRoomController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  TypeRoomModel? selectedTypeRoom;
  List<ConvenientModel?>? selectedConvenients;
  StatusRoomModel? selectedStatusRoom;
  List<ConvenientModel> filteredConvenientList = [];
  List<TypeRoomModel> filteredTypeList = [];
  List<StatusRoomModel> filteredStatusRoomList = [];

  @override
  void initState() {
    super.initState();
    initializeFields();
    fetchConvenientList();
    fetchStatusRoomList();
    fetchTypeRoomList();
  }

  void initializeFields() {
    nameRoomController.text = widget.room.idRoom;
    descriptionRoomController.text = widget.room.description;
    priceController.text = widget.room.priceRoom.toString();
    capacityController.text = widget.room.capacity.toString();

    selectedTypeRoom = widget.room.typeRoom;
    selectedConvenients = widget.room.convenient;
    selectedStatusRoom = widget.room.statusRoom;
  }

  void fetchConvenientList() async {
    QuerySnapshot convenientSnapshot =
        await FirebaseFirestore.instance.collection('convenients').get();
    List<ConvenientModel> convenients = convenientSnapshot.docs.map((doc) {
      String idConvenient = doc['idConvenient'] as String;
      String nameConvenient = doc['nameConvenient'] as String;
      return ConvenientModel(idConvenient, nameConvenient);
    }).toList();
    setState(() {
      filteredConvenientList = convenients;
      selectedConvenients = [];
    });
  }

  void fetchStatusRoomList() async {
    QuerySnapshot convenientSnapshot =
        await FirebaseFirestore.instance.collection('statusRooms').get();
    List<StatusRoomModel> statusRooms = convenientSnapshot.docs.map((doc) {
      String idStatus = doc['idStatus'] as String;
      String description = doc['description'] as String;
      return StatusRoomModel(idStatus, description);
    }).toList();
    setState(() {
      filteredStatusRoomList = statusRooms;
    });
  }

  void fetchTypeRoomList() async {
    try {
      QuerySnapshot typeRoomSnapshot =
          await FirebaseFirestore.instance.collection('typeRooms').get();
      List<TypeRoomModel> typeRooms = typeRoomSnapshot.docs.map((doc) {
        String idTypeRoom = doc.id; // Lấy ID của tài liệu (document)
        String nameTypeRoom = doc.get('nameTypeRoom')
            as String; // Lấy dữ liệu từ trường 'nameTypeRoom'
        return TypeRoomModel(idTypeRoom, nameTypeRoom);
      }).toList();
      setState(() {
        filteredTypeList = typeRooms;
      });
    } catch (e) {
      // Xử lý lỗi khi truy xuất dữ liệu từ Firestore
      print('Error fetching type room list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!filteredTypeList.contains(selectedTypeRoom)) {
      selectedTypeRoom =
          filteredTypeList.isNotEmpty ? filteredTypeList[0] : null;
    }
    if (!filteredStatusRoomList.contains(selectedStatusRoom)) {
      selectedStatusRoom =
          filteredStatusRoomList.isNotEmpty ? filteredStatusRoomList[0] : null;
    }

    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Room ${widget.room.idRoom}',
          style: const TextStyle(color: AppColorsExt.textColor),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColorsExt.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormFieldWidget(
                  controller: nameRoomController,
                  hintText: 'Id Room',
                  prefixIcon: const Icon(Icons.insert_drive_file_outlined),
                  displaySuffixIcon: false,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {},
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<TypeRoomModel>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.bed,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Type Room',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: filteredTypeList
                        .map((TypeRoomModel item) =>
                            DropdownMenuItem<TypeRoomModel>(
                              value: item,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.airline_seat_individual_suite_rounded,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    item.nameTypeRoom,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    value: selectedTypeRoom,
                    onChanged: (value) {
                      setState(() {
                        selectedTypeRoom = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.only(right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: descriptionRoomController,
                  hintText: 'Description Room',
                  prefixIcon: const Icon(Icons.description),
                  displaySuffixIcon: false,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                    controller: priceController,
                    hintText: "Price",
                    prefixIcon: Icon(Icons.price_change),
                    displaySuffixIcon: false,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                    controller: capacityController,
                    hintText: "Capacity",
                    prefixIcon: const Icon(Icons.people_outline),
                    displaySuffixIcon: false,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      return null;
                    }),
                const SizedBox(height: 20),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<StatusRoomModel>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.library_add_check_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: filteredStatusRoomList
                        .map((StatusRoomModel item) =>
                            DropdownMenuItem<StatusRoomModel>(
                              value: item,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.library_add_check_outlined,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    value: selectedStatusRoom,
                    onChanged: (value) {
                      setState(() {
                        selectedStatusRoom = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.only(right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.checklist_rounded),
                      const Text(
                        ' Convenients: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: filteredConvenientList.map((convenient) {
                          final bool isChecked =
                              selectedConvenients!.contains(convenient);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (isChecked) {
                                  selectedConvenients!.remove(convenient);
                                } else {
                                  selectedConvenients!.add(convenient);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isChecked ? Colors.blue : Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                convenient.nameConvenient,
                                style: TextStyle(
                                  color:
                                      isChecked ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform the update action here
                      adminRoomController.updateDetailsRoomInFireStore(
                        context,
                        widget.room.idRoom,
                        selectedTypeRoom!,
                        selectedConvenients!,
                        descriptionRoomController.text,
                        int.parse(priceController.text),
                        int.parse(capacityController.text),
                        selectedStatusRoom!,
                      );
                      Navigator.pop(context, widget.room);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Edit Room success"),
                        duration: Duration(seconds: 4),
                      ));
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
