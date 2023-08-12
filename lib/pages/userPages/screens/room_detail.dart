import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_url_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/pages/generalPages/booking_page.dart';
import 'package:n100_hotel_booking/pages/userPages/widgets/review_room.dart';

class RoomDetail extends StatefulWidget {
  const RoomDetail({Key? key, required this.room}) : super(key: key);
  final RoomModel room;

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    User? user = _auth.currentUser;
    setState(() {
      _currentUser = user;
    });

    if (_currentUser != null) {
      _getUserModel(_currentUser!.email!);
    }
  }

  void _getUserModel(String email) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot userDocument = snapshot.docs.first;
        _userModel = UserModel(
          nameUser: userDocument['name'],
          birthday: userDocument['birthday'],
          phoneNumber: userDocument['phone'],
          imageUrl: userDocument['imageUrl'],
          role: userDocument['role'],
          email: userDocument['email'],
          address: userDocument['address'],
          gender: userDocument['gender'],
        );
        print('${_userModel!.nameUser} -----------------------------------');
      } else {
        print('khong co -----------------------------------');
      }
    } catch (e) {
      // Handle any errors that might occur during the database query.
      print('Error fetching user data: $e');
    }
  }

  void _navigateToBookingPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(
          selectedRoom: widget.room,
          currentUser: _userModel!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Detail'),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToBookingPage();
            },
            icon: const Icon(Icons.add_business_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.room.idRoom,
              child: widget.room.images!.isNotEmpty
                  ? SizedBox(
                      height: 200, // Chiều cao của PageView ảnh
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.room.images!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.room.images![index]!,
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        AppUrlExt.defaultRoomImage,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.room.idRoom,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
                      Text('Total Rate: '),
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 230, 0),
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 230, 0),
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 230, 0),
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 230, 0),
                        size: 16,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Color.fromARGB(255, 255, 230, 0),
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // const Row(
                  //   children: [
                  //     Icon(Icons.location_on_outlined, size: 16),
                  //     SizedBox(width: 4),
                  //     Text(
                  //       'Hanoi, Vietnam',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const Divider(),
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.room.priceRoom.toString()} VND',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Capacity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.room.capacity.toString()} Person',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Type Room',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.room.typeRoom.nameTypeRoom,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.room.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  for (var convenience in widget.room.convenient!)
                    Text('- ${convenience?.nameConvenient ?? ""}',
                        style: const TextStyle(color: Colors.black)),
                  const Divider(),
                  const Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const ReviewRoom(),
                  const ReviewRoom(),
                  const ReviewRoom(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
