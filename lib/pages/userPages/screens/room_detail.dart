import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/constants/app_url_ext.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/pages/userPages/widgets/review_room.dart';
import 'package:n100_hotel_booking/pages/userPages/widgets/room_trait.dart';

class RoomDetail extends StatelessWidget {
  const RoomDetail({
    super.key,
    required this.room,
  });

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Detail'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: room.idRoom,
              child: room.images!.isNotEmpty
                  ? SizedBox(
                      height: 200, // Chiều cao của PageView ảnh
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: room.images!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  room.images![index]!,
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
                    room.idRoom,
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
                    '${room.priceRoom.toString()} VND',
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
                    '${room.capacity.toString()} Person',
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
                    room.typeRoom.nameTypeRoom,
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
                    room.description,
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
                  for (var convenience in room.convenient!)
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
