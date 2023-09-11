import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/expansionPanel/app_expansion_panel_controller.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/pages/userPages/user_home.dart';

class BookingSuccessPage extends GetView<UserController> {
  BookingSuccessPage({super.key});

  @override
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextHeading3Widget()
                    .setText("BOOKING SUCCESS")
                    .setTextStyle(AppTextStyleExt.of.textBody1s)
                    .setColor(AppColors.of.yellowColor[6])
                    .build(context),
                AppExpansionPanelWidget(
                  header: const Text("What to do with this QR Code?"),
                  body: AppTextBody1Widget()
                      .setText(
                          "Your booking request has been sent to the hotel, please use this QR code to pay via VNPAY e-wallet and wait for confirmation from the hotel. You can view the booking status on the history page on the home page.")
                      .setTextStyle(AppTextStyleExt.of.textBody1s)
                      .setColor(AppColors.of.grayColor[6])
                      .build(context),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/defaultImage/vnpay_qr.png'),
                ),
                AppOutlinedButtonWidget()
                    .setButtonText("Get back to home page")
                    .setOnPressed(() {
                  Get.offAll(() => UserHome());
                }).build(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
