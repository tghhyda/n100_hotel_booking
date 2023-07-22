import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';

import 'edit_room_page.dart';

class RoomDetailPage extends StatefulWidget {
  final RoomModel room;

  const RoomDetailPage({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  late RoomModel _updateRoom = widget.room;

  void _navigateToEditRoom() async {
    final editedRoom = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRoomPage(room: _updateRoom),
      ),
    );

    if (editedRoom != null) {
      setState(() {
        _updateRoom = editedRoom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Detail Room ${_updateRoom.idRoom}',
          style: const TextStyle(color: AppColorsExt.textColor),
        ),
        backgroundColor: AppColorsExt.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _navigateToEditRoom,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 200, // Chiều cao của PageView ảnh
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _updateRoom.images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(_updateRoom.images![index]!),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Type Room: ${_updateRoom.typeRoom.nameTypeRoom}',
                style: const TextStyle(
                    color: AppColorsExt.textColor, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Text('Price: ${_updateRoom.priceRoom} VND',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              Text('Capacity: ${_updateRoom.capacity} person',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              Text('Status room: ${_updateRoom.statusRoom.description}',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Convenient:',
                      style: TextStyle(
                          color: AppColorsExt.textColor, fontSize: 18)),
                  for (var convenience in _updateRoom.convenient!)
                    Text('- ${convenience?.nameConvenient ?? ""}',
                        style: const TextStyle(
                            color: AppColorsExt.textColor, fontSize: 18)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description:',
                      style: TextStyle(
                          color: AppColorsExt.textColor, fontSize: 18)),
                  Text(
                    _updateRoom.description,
                    style: const TextStyle(
                        color: AppColorsExt.textColor,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 5,
                  ),
                ],
              ),
              const Divider(),
              const Text(
                'Reviews:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColorsExt.textColor),
              ),
              for (var review in _updateRoom.review!)
                ListTile(
                  title: Text(review?.user ?? ""),
                  subtitle: Text(review?.detailReview ?? ""),
                  trailing: Text('${review?.rate ?? 0}/5'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
