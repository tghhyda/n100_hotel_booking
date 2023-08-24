import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/overlay/app_loading_overlay_widget.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:uuid/uuid.dart';

class AdminRoomPostReviewView extends GetView<UserController> {
  AdminRoomPostReviewView({super.key});

  @override
  final controller = Get.put(UserController());

  TextEditingController reviewController = TextEditingController();

  final RoomModel roomModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (reviewController.text.isNotEmpty ||
                  controller.rating!.value > 0) {
                AppDefaultDialogWidget()
                    .setIsHaveCloseIcon(true)
                    .setContent("Cancel draft?")
                    .setNegativeText("Cancel")
                    .setPositiveText("Keep")
                    .setOnNegative(() {
                      Get.back();
                    })
                    .buildDialog(context)
                    .show();
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.close)),
        title: Column(
          children: [
            AppTextBody1Widget().setText("Rate this room").build(context)
          ],
        ),
        actions: [
          AppTextButtonWidget().setButtonText("Post").setOnPressed(() async {
            if (controller.rating!.value > 0) {
              final ReviewModel reviewModel = ReviewModel(
                  controller.generateRandomId(),
                  FirebaseAuth.instance.currentUser!.email!,
                  roomModel.idRoom,
                  DateTime.now(),
                  reviewController.text,
                  double.parse(controller.rating!.value.toString()));
              await controller.postReviewAndUpdateRoomModel(
                  reviewModel, roomModel).then((value){
                    controller.rating?.value = 0;
                    Get.back();
                    AppSnackBarWidget()
                        .setContent(const Text("Post Review Success"))
                        .setShowOnTop(SnackPosition.TOP)
                        .setAppSnackBarType(AppSnackBarType.toastMessage)
                        .showSnackBar(Get.context!);
              });
            }
          }).build(context)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: controller.currentUser?.imageUrl != null
                      ? Image.network(
                          controller.currentUser!.imageUrl!,
                          height: 35,
                          width: 35,
                        )
                      : Image.asset(
                          height: 35,
                          width: 35,
                          'assets/defaultImage/user_default_avatar.png'),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextSubTitle1Widget()
                          .setText("${controller.currentUser?.nameUser}")
                          .setTextStyle(AppTextStyleExt.of.textSubTitle1s)
                          .build(context),
                      const SizedBox(
                        height: 4,
                      ),
                      AppTextSubTitle2Widget()
                          .setText(
                              "These are public reviews and contain your device information")
                          .setColor(AppColors.of.grayColor[7])
                          .setMaxLines(3)
                          .setTextOverFlow(TextOverflow.ellipsis)
                          .build(context)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        controller.rating?.value = i;
                      },
                      child: Icon(
                        i <= controller.rating!.value
                            ? Icons.star
                            : Icons.star_outline,
                        size: 35,
                        color: i <= controller.rating!.value
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            AppOutlineTextFormFieldWidget()
                .setController(reviewController)
                .setMaxLength(300)
                .setHintText("Describe your experience (Optional)")
                .setMaxLine(4)
                .build(context),
          ],
        )),
      ),
    );
  }
}
