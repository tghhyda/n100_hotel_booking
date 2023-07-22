import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_url_ext.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
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
              tag: room.idRoom,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(room.images!.isNotEmpty ? (room.images![0] ??
                    AppUrlExt.defaultRoomImage) : AppUrlExt.defaultRoomImage)  ,
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
                      room.idRoom,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoomItemTrait(
                          icon: Icons.people,
                          label: '${room.capacity.toString()} person',
                          colorTrait: Colors.white,
                        ),
                        RoomItemTrait(
                          icon: Icons.attach_money,
                          label: room.priceRoom.toString(),
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
