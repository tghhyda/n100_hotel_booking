import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class UserDetailPage extends StatefulWidget {
  final UserModel user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Detail User ${widget.user.nameUser}',
          style: const TextStyle(color: AppColorsExt.textColor),
        ),
        backgroundColor: AppColorsExt.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.user.imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Name: ${widget.user.nameUser}',
                style: const TextStyle(
                    color: AppColorsExt.textColor, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Text('Birthday: ${widget.user.birthday}',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              Text('Phone: ${widget.user.phoneNumber}',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              Text('Email: ${widget.user.email}',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              Text('Address: ${widget.user.address}',
                  style: const TextStyle(
                      color: AppColorsExt.textColor, fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
