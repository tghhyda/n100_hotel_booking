import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room_model.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/room_detail.dart';
import 'package:n100_hotel_booking/pages/userPages/widgets/room_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({
    super.key,
    required this.room,
  });

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => RoomDetail(room: room)),
          );
        },
        child: Stack(
          children: [
            Hero(
              tag: room.name,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const NetworkImage(
                    'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80'),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      room.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoomItemTrait(
                          icon: Icons.people,
                          label: '2 người',
                          colorTrait: Colors.white,
                        ),
                        RoomItemTrait(
                          icon: Icons.attach_money,
                          label: '1.000.000 VNĐ',
                          colorTrait: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
