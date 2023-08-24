import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/history_page.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:n100_hotel_booking/pages/userPages/user_home.dart';

import '../../../components/snackBar/app_snack_bar_base_builder.dart';

class BookingPage extends GetView<UserController> {
  BookingPage({super.key});

  @override
  final controller = Get.put(UserController());

  final roomId = Get.arguments;
  late RoomModel selectedRoom;
  TextEditingController promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = controller.currentUser;
    int stayNights = controller.selectedDates.value.duration.inDays;

    return Scaffold(
      body: FutureBuilder<RoomModel>(
        future: controller.getRoomById(roomId),
        // Assume this returns a Future<RoomModel>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          selectedRoom = snapshot.data!;
          double stayPrice = stayNights.toDouble() * selectedRoom.priceRoom;
          double taxes = (stayPrice * 6.5) / 100;
          double totalPrice = stayPrice + taxes;

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                expandedHeight: 200,
                title: AppTextBody1Widget()
                    .setText("${selectedRoom.typeRoom.nameTypeRoom}")
                    .setTextStyle(AppTextStyleExt.of.textBody1s)
                    .setColor(AppColors.of.grayColor[10])
                    .build(context),
                flexibleSpace: FlexibleSpaceBar(
                  background: selectedRoom.images!.isNotEmpty
                      ? Image.network(
                          selectedRoom.images![0]!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/adsImage/room4.png',
                          fit: BoxFit.cover,
                        ),
                  titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
                  title: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.of.yellowColor[5],
                        size: 20,
                      ),
                      AppTextSubTitle1Widget()
                          .setText(controller
                              .getRating(selectedRoom)
                              .toStringAsFixed(1))
                          .setColor(AppColors.of.grayColor[1])
                          .build(context),
                      const SizedBox(
                        width: 12,
                      ),
                      AppTextSubTitle1Widget()
                          .setText('${selectedRoom.review?.length} reviews')
                          .setColor(AppColors.of.grayColor[1])
                          .build(context),
                    ],
                  ),
                ),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextBody1Widget()
                              .setText("ROOM INFORMATION")
                              .setColor(AppColors.of.grayColor[9])
                              .setTextStyle(AppTextStyleExt.of.textBody1s)
                              .build(context),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Room Type")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText(
                                            "${selectedRoom.typeRoom.nameTypeRoom}")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Room")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText(
                                            "$stayNights Nights (${selectedRoom.priceRoom} x $stayNights = $stayPrice)")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Taxes")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText("$taxes")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Total")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText("$totalPrice")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 12,
                          ),
                          AppTextBody1Widget()
                              .setText("GUESS INFORMATION")
                              .setColor(AppColors.of.grayColor[9])
                              .setTextStyle(AppTextStyleExt.of.textBody1s)
                              .build(context),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Room Type")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText("${userModel?.nameUser}")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Email")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText("${userModel?.email}")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    AppTextSubTitle1Widget()
                                        .setText("Mobile number")
                                        .setColor(AppColors.of.grayColor[7])
                                        .build(context),
                                    const Spacer(),
                                    AppTextSubTitle1Widget()
                                        .setText("${userModel?.phoneNumber}")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textSubTitle1s)
                                        .setColor(AppColors.of.grayColor[10])
                                        .build(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 12,
                          ),
                          AppTextBody1Widget()
                              .setText("PROMO CODE")
                              .setColor(AppColors.of.grayColor[9])
                              .setTextStyle(AppTextStyleExt.of.textBody1s)
                              .build(context),
                          AppTextSubTitle1Widget()
                              .setText(
                                  "If you have promo code please enter it below")
                              .setColor(AppColors.of.grayColor[7])
                              .setTextStyle(AppTextStyleExt.of.textSubTitle1r)
                              .build(context),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: AppOutlineTextFormFieldWidget()
                                  .setController(promoController)
                                  .setHintText("Enter promo code")
                                  .setMaxLength(10)
                                  .build(context))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.of.yellowColor[5],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            if (stayNights > 0) {
              final BookingModel bookingModel = BookingModel(
                  userModel?.email,
                  selectedRoom.idRoom,
                  controller.selectedDates.value.start,
                  controller.selectedDates.value.end,
                  controller.theNumberOfRooms?.value,
                  controller.theNumberOfAdult?.value,
                  controller.theNumberOfChildren?.value,
                  promoController.text,
                  [],
                  (stayNights.toDouble() * selectedRoom.priceRoom) +
                      (((stayNights.toDouble() * selectedRoom.priceRoom) *
                              6.5) /
                          100),
                  false,
                  false,
                  false,
                  false,
                  false,
                  DateTime.now());
              controller.addBookingToFirestore(bookingModel);
              Get.offAll(UserHome());
              AppSnackBarWidget()
                  .setAppSnackBarType(AppSnackBarType.toastMessage)
                  .setAppSnackBarStatus(AppSnackBarStatus.success)
                  .setShowOnTop(SnackPosition.TOP)
                  .setContent(const Text("Order success"))
                  .showSnackBar(context);
            } else {
              AppSnackBarWidget()
                  .setAppSnackBarType(AppSnackBarType.toastMessage)
                  .setAppSnackBarStatus(AppSnackBarStatus.error)
                  .setContent(const Text("Stay at least 1 night"))
                  .showSnackBar(context);
            }
          },
          child: AppTextBody1Widget()
              .setTextStyle(AppTextStyleExt.of.textBody1s)
              .setText("Confirm order")
              .build(context),
        ),
      ),
    );
  }
}
