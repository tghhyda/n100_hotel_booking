import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/room/convenient_model.dart';
import 'package:n100_hotel_booking/models/room/status_room_model.dart';
import 'package:n100_hotel_booking/models/room/type_room_model.dart';
import 'admin_room_controller.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key, required this.onAddRoomCallback});

  final void Function() onAddRoomCallback;

  @override
  _AddRoomPageState createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  _AddRoomPageState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController nameRoomController = TextEditingController();
  final TextEditingController descriptionRoomController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  TypeRoomModel? selectedTypeRoom;
  List<ConvenientModel>? selectedConvenients;
  StatusRoomModel? selectedStatusRoom;

  List<ConvenientModel> filteredConvenientList = [];
  List<TypeRoomModel> filteredTypeList = [];
  List<StatusRoomModel> filteredStatusRoomList = [];

  @override
  void initState() {
    super.initState();
    fetchTypeRoomList();
    fetchConvenientList();
    fetchStatusRoomList();
    selectedTypeRoom = filteredTypeList.isNotEmpty ? filteredTypeList[0] : null;
    selectedStatusRoom =
        filteredStatusRoomList.isNotEmpty ? filteredStatusRoomList[1] : null;
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

  List<File> selectedImages = [];

  void _onSelectImages() async {
    List<File> images = await pickMultipleImages();
    setState(() {
      selectedImages = images;
    });
  }

  void _onUploadImages() async {
    String roomId = nameRoomController
        .text; // Sử dụng mã phòng hoặc bất kỳ định danh duy nhất nào cho các ảnh
    List<String> imageUrls =
        await uploadImagesToFirebase(selectedImages, roomId);
    FirebaseFirestore.instance.collection('rooms').doc(roomId).set({
      'images': imageUrls,
    }, SetOptions(merge: true));
    // Làm một cái gì đó với đường dẫn của ảnh, như lưu chúng vào cơ sở dữ liệu.
  }

  @override
  Widget build(BuildContext context) {
    final adminRoomController = AdminRoomController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Room'),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: AppColorsExt.primaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormFieldWidget(
                          controller: nameRoomController,
                          hintText: 'Id Room',
                          prefixIcon:
                              const Icon(Icons.insert_drive_file_outlined),
                          displaySuffixIcon: false,
                          validator: (value) {
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                            Icons
                                                .airline_seat_individual_suite_rounded,
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
                                borderRadius: BorderRadius.circular(20),
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
                        const SizedBox(
                          height: 20,
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),
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
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white,
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColorsExt.backgroundColor,
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
                                children:
                                    filteredConvenientList.map((convenient) {
                                  final bool isChecked =
                                      selectedConvenients!.contains(convenient);
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isChecked) {
                                          selectedConvenients!
                                              .remove(convenient);
                                        } else {
                                          selectedConvenients!.add(convenient);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isChecked
                                            ? Colors.blue
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        convenient.nameConvenient,
                                        style: TextStyle(
                                          color: isChecked
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                File imageFile = selectedImages[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(imageFile),
                                );
                              }),
                        ),
                        ElevatedButton(
                          onPressed: _onSelectImages,
                          child: const Text('Add Images'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                const CircularProgressIndicator();
                                Navigator.pop(context);
                                setState(() {});
                              },
                              color: Colors.white,
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                _onUploadImages();
                                adminRoomController.postDetailsRoomToFireStore(
                                  context,
                                  _formkey,
                                  nameRoomController.text,
                                  selectedTypeRoom!,
                                  selectedConvenients!,
                                  descriptionRoomController.text,
                                  int.parse(priceController.text),
                                  int.parse(capacityController.text),
                                  selectedStatusRoom!,
                                );
                                Navigator.pop(context);
                                widget.onAddRoomCallback();
                              },
                              color: Colors.white,
                              child: const Text(
                                "Add Room",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<File>> pickMultipleImages() async {
    List<XFile>? selectedFiles = await ImagePicker().pickMultiImage();
    if (selectedFiles == null) return [];

    List<File> images = [];
    for (XFile file in selectedFiles) {
      images.add(File(file.path));
    }
    return images;
  }

  Future<List<String>> uploadImagesToFirebase(
      List<File> images, String roomId) async {
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      String imageName = '$roomId-image-$i.jpg'; // Đặt tên duy nhất cho mỗi ảnh
      Reference ref =
          FirebaseStorage.instance.ref().child('room_images').child(imageName);

      await ref.putFile(images[i]);

      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }
}
