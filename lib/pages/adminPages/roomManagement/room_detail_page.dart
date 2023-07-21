import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';

class RoomDetailPage extends StatefulWidget {
  final RoomModel room;

  const RoomDetailPage({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết phòng'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200, // Chiều cao của ListView ảnh
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.room.images!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(widget.room.images![index]!),
                  );
                },
              ),
            ),
            ListTile(
              title: Text('Loại phòng: ${widget.room.typeRoom.nameTypeRoom}'),
              subtitle: Text('Giá phòng: ${widget.room.priceRoom} VND'),
            ),
            ListTile(
              title: Text('Sức chứa: ${widget.room.capacity} người'),
              subtitle: Text('Tình trạng phòng: ${widget.room.statusRoom.description}'),
            ),
            ListTile(
              title: const Text('Tiện nghi:'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var convenience in widget.room.convenient!)
                    Text('- ${convenience?.nameConvenient ?? ""}'),
                ],
              ),
            ),
            ListTile(
              title: const Text('Mô tả phòng:'),
              subtitle: Text(widget.room.description),
            ),
            const Divider(),
            const Text(
              'Đánh giá:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var review in widget.room.review!)
              ListTile(
                title: Text(review?.user ?? ""),
                subtitle: Text(review?.detailReview ?? ""),
                trailing: Text('${review?.rate ?? 0}/5'),
              ),
          ],
        ),
      ),
    );
  }
}
