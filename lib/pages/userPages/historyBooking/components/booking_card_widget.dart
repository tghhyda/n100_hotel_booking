import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/generalPages/components/divider_widget.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/history_controller.dart';

class BookingCardWidget extends GetView<HistoryController> {
  BookingCardWidget(
      {super.key, required this.bookingModel, required this.onPressed});

  @override
  final controller = Get.put(HistoryController());

  final BookingModel bookingModel;
  final void Function() onPressed;

  ImageIcon _getBookingStatusIcon() {
    if (bookingModel.isCancelBooking == true) {
      return ImageIcon(const AssetImage("assets/bookingStatus/cancel_icon.png"),
          size: 100, color: AppColors.of.redColor[5]);
    }
    if (bookingModel.isConfirm == false) {
      return ImageIcon(
        const AssetImage("assets/bookingStatus/waiting_icon.png"),
        size: 100,
        color: AppColors.of.yellowColor[5],
      );
    } else if (bookingModel.isCheckIn == true) {
      if (bookingModel.isPaid == false) {
        return ImageIcon(
          const AssetImage("assets/bookingStatus/stay_icon.png"),
          size: 100,
          color: AppColors.of.lightBlueColor[5],
        );
      }
      return ImageIcon(
        const AssetImage("assets/bookingStatus/paid_icon.png"),
        size: 100,
        color: AppColors.of.lightBlueColor[7],
      );
    }
    return ImageIcon(
      const AssetImage("assets/bookingStatus/confirm_icon.png"),
      size: 100,
      color: AppColors.of.greenColor[5],
    );
  }

  bool _showPopupMenu() {
    if (bookingModel.isConfirm == true) {
      return true;
    } else {
      if (bookingModel.startDate!.difference(DateTime.now()).inDays <= 1) {
        return false;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.of.grayColor[1],
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.of.grayColor[7]!.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(1, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getBookingStatusIcon(),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<RoomModel>(
                    future: controller.getRoomById(bookingModel.room!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Text('Room data not available.');
                      } else {
                        RoomModel room = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextBody1Widget()
                                .setText("Type: ${room.typeRoom.nameTypeRoom!}")
                                .setMaxLines(2)
                                .setTextOverFlow(TextOverflow.ellipsis)
                                .build(context),
                            AppTextBody1Widget()
                                .setText(
                                    "Start-Date: ${DateFormat('dd/MM/yyyy').format(bookingModel.startDate!)}")
                                .setMaxLines(2)
                                .setTextOverFlow(TextOverflow.ellipsis)
                                .build(context),
                            AppTextBody1Widget()
                                .setText(
                                    "End-Date: ${DateFormat('dd/MM/yyyy').format(bookingModel.endDate!)}")
                                .build(context),
                            DividerWidget(
                                title:
                                    "${bookingModel.endDate!.difference(bookingModel.startDate!).inDays} Nights"),
                            AppTextBody1Widget()
                                .setText(
                                    "Total cost: ${bookingModel.totalPrice} VND")
                                .setMaxLines(2)
                                .setTextOverFlow(TextOverflow.ellipsis)
                                .build(context),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            if (_showPopupMenu())
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (String choice) {
                  if (choice == "cancelBooking") {
                    controller.updateBookingIsCancelStatusByUserAndRoom(
                        controller.currentUser!.email,
                        bookingModel.room!,
                        true);
                  }
                  if (choice == "turnOff") {
                    controller.updateBookingIsCancelStatusByUserAndRoom(
                        controller.currentUser!.email,
                        bookingModel.room!,
                        false);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    if (bookingModel.isCancelBooking == false)
                      const PopupMenuItem<String>(
                        value: 'cancelBooking',
                        child: Text('Cancel'),
                      ),
                    if (bookingModel.isCancelBooking == true)
                      const PopupMenuItem<String>(
                        value: 'turnOff',
                        child: Text('Turn off request'),
                      ),
                  ];
                },
              )
          ],
        ),
      ),
    );
  }
}
