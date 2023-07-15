import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room_model.dart';
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
              tag: room.name,
              child: Image.network(
                'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
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
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Hanoi, Vietnam',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
                  const RoomItemTrait(
                    icon: Icons.wifi,
                    label: 'Free Wifi',
                    colorTrait: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  const RoomItemTrait(
                    icon: Icons.local_parking,
                    label: 'Parking',
                    colorTrait: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  const RoomItemTrait(
                    icon: Icons.smoke_free,
                    label: 'No Smoking',
                    colorTrait: Colors.grey,
                  ),
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
