import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AdminRoomDetailPhotoView extends StatelessWidget {
  AdminRoomDetailPhotoView({Key? key, required this.listImage}) : super(key: key);

  final List<String?>? listImage;

  List<String> listDefaultRoomImage = [
    'assets/adsImage/room1.png',
    'assets/adsImage/room2.png',
    'assets/adsImage/room3.png',
    'assets/adsImage/room4.png'
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
        context: context,
        removeTop: true,
        child: listImage!.isNotEmpty
            ? AlignedGridView.count(
                crossAxisCount: 3,
                itemCount: listImage!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Open image preview here
                      _showImagePreviewNetwork(context, listImage![index]!);
                    },
                    child: Image.network(
                      listImage![index]!,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : AlignedGridView.count(
                crossAxisCount: 3,
                itemCount: listDefaultRoomImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Open image preview here
                      _showImagePreviewAsset(context, listDefaultRoomImage[index]);
                    },
                    child: Image.asset(
                      listDefaultRoomImage[index],
                      height: 100,
                      // width: 10,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ));
  }

  void _showImagePreviewNetwork(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  void _showImagePreviewAsset(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
