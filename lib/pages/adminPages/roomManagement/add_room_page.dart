import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/dropdownButton/dropdown_button_widget.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/room/convenient_model.dart';
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
  TypeRoomModel? selectedTypeRoom;

  List<ConvenientModel> filteredConvenientList = [];
  List<TypeRoomModel> filteredTypeList = [];

  @override
  void initState() {
    super.initState();
    fetchTypeRoomList(); // Gọi phương thức fetchTypeRoomList ở đây
    selectedTypeRoom = filteredTypeList.isNotEmpty ? filteredTypeList[0] : null;
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
      print('Error fetching type room listtttttttttttttttttttttttttt: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminRoomController = AdminRoomController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Room'),
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
                          prefixIcon: const Icon(Icons.bed),
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
                                  Icons.apartment,
                                  size: 16,
                                  color: Colors.grey,
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
                                          const SizedBox(width: 12,),
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
                        const SizedBox(
                          height: 20,
                        ),
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
                                // handleUploadImage(context);
                                adminRoomController.postDetailsRoomToFireStore(
                                    context,
                                    _formkey,
                                    nameRoomController.text,
                                    selectedTypeRoom!,
                                    descriptionRoomController.text);
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
}
