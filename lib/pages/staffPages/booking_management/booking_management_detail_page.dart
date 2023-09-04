import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/toolTip/app_tooltip_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/admin_room_view_detail.dart';
import 'package:n100_hotel_booking/pages/adminPages/userManagement/detail_user_page.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/booking_management_controller.dart';

class BookingManagementDetailPage extends GetView<BookingManagementController> {
  BookingManagementDetailPage({super.key});

  @override
  final controller = Get.put(BookingManagementController());

  BookingModel bookingModel = Get.arguments;
  RoomModel? roomModel;
  String typeRoom = 'Single room';
  RxList<EntityRoomModel>? selectedEntityRoom = <EntityRoomModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Booking'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    AppTooltipWidget()
                        .setText("Click image to view detail")
                        .setIcon(Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.of.lightBlueColor[6],
                        ))
                        .build(context),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder<UserModel>(
                              future: controller
                                  .getUserInfoByEmail(bookingModel.user!),
                              builder: (context, userSnapshot) {
                                if (userSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (userSnapshot.hasError) {
                                  return Text('Error: ${userSnapshot.error}');
                                } else if (!userSnapshot.hasData) {
                                  return const Text('User not found');
                                }

                                UserModel user = userSnapshot.data!;

                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => UserDetailPage(user: user));
                                      },
                                      child: user.imageUrl?.isNotEmpty == true
                                          ? Image.network(
                                              user.imageUrl!,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/defaultImage/user_default_avatar.png',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                    )
                                  ],
                                );
                              }),
                          AppTextBody1Widget()
                              .setText("Booking")
                              .setColor(AppColors.of.yellowColor[6])
                              .setTextStyle(AppTextStyleExt.of.textBody1s)
                              .build(context),
                          FutureBuilder<RoomModel>(
                              future:
                                  controller.getRoomById(bookingModel.room!),
                              builder: (context, roomSnapshot) {
                                if (roomSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (roomSnapshot.hasError) {
                                  return Text('Error: ${roomSnapshot.error}');
                                } else if (!roomSnapshot.hasData) {
                                  return const Text('Room not found');
                                }

                                RoomModel room = roomSnapshot.data!;
                                roomModel = room;
                                typeRoom = room.typeRoom.nameTypeRoom!;

                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => AdminRoomDetailPage(),
                                            arguments: room);
                                      },
                                      child: room.images?.isNotEmpty == true
                                          ? Image.network(
                                              room.images!.first!,
                                              height: 120,
                                              width: 120,
                                            )
                                          : Image.asset(
                                              'assets/adsImage/room1.png',
                                              height: 120,
                                              width: 120,
                                            ),
                                    )
                                  ],
                                );
                              }),
                        ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextBody1Widget()
                        .setText("BOOKING INFORMATION")
                        .setTextStyle(AppTextStyleExt.of.textBody1s)
                        .setColor(AppColors.of.yellowColor[6])
                        .build(context),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Room type:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText(typeRoom)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Booking time:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText(DateFormat('HH:mm:ss - dd/MM/yyyy')
                                .format(bookingModel.createAt!))
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Start date:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText(DateFormat('dd/MM/yyyy')
                                .format(bookingModel.startDate!))
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("End date:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText(DateFormat('dd/MM/yyyy')
                                .format(bookingModel.endDate!))
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Quantity:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText('${bookingModel.numberOfRooms} Room(s)')
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Adult:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText('${bookingModel.numberOfAdult} People')
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Children:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText(
                                '${bookingModel.numberOfChildren} Children')
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        AppTextBody1Widget()
                            .setText("Total cost:")
                            .setColor(AppColors.of.grayColor[7])
                            .build(context),
                        const Spacer(),
                        AppTextBody1Widget()
                            .setText(
                                "${controller.formatPrice(bookingModel.totalPrice!.toInt())} VND")
                            .setMaxLines(2)
                            .setTextOverFlow(TextOverflow.ellipsis)
                            .setColor(AppColors.of.redColor)
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .build(context),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppTextBody1Widget()
                              .setText("BOOKING STATUS")
                              .setTextStyle(AppTextStyleExt.of.textBody1s)
                              .setColor(AppColors.of.yellowColor[6])
                              .build(context),
                          const SizedBox(
                            width: 12,
                          ),
                          AppTooltipWidget()
                              .setText("Click arrow to change to next status")
                              .setIcon(Icon(
                                Icons.info_outline_rounded,
                                color: AppColors.of.lightBlueColor[6],
                              ))
                              .build(context)
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              AppTextBody1Widget()
                                  .setText("CURRENT STATUS")
                                  .setTextStyle(AppTextStyleExt.of.textBody1s)
                                  .setColor(AppColors.of.lightBlueColor[6])
                                  .build(context),
                              const SizedBox(
                                height: 12,
                              ),
                              _getBookingStatusIcon()
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                switch (_getStatus()) {
                                  case 'waiting':
                                    print('waiting');
                                    AppDefaultDialogWidget()
                                        .setAppDialogType(AppDialogType.confirm)
                                        .setTitle("Confirm change status")
                                        .setContent(
                                            "Are you sure to change status to confirm?")
                                        .setPositiveText("Yes")
                                        .setNegativeText("No")
                                        .setOnPositive(() async {
                                          await controller
                                              .updateBookingIsConfirm(
                                                  bookingModel.bookingId!,
                                                  true);
                                        })
                                        .buildDialog(context)
                                        .show();
                                    break;
                                  case 'confirm':
                                    if (roomModel != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: const Text(
                                                  'Choose Entity Room'),
                                              content: Wrap(
                                                spacing: 8,
                                                children: listAvailableRoom(
                                                        roomModel!)
                                                    .map((entity) {
                                                  return Obx(
                                                    () => InputChip(
                                                      label: Text(entity.name),
                                                      selected:
                                                          selectedEntityRoom!
                                                              .contains(entity),
                                                      selectedColor: AppColors
                                                          .of.yellowColor[5],
                                                      onSelected: (isSelected) {
                                                        if (isSelected) {
                                                          selectedEntityRoom
                                                              ?.add(entity);
                                                          print(
                                                              '${selectedEntityRoom?.length}');
                                                        } else {
                                                          selectedEntityRoom
                                                              ?.remove(entity);
                                                          print(
                                                              '${selectedEntityRoom?.length}');
                                                        }
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          AppOutlinedButtonWidget()
                                                              .setButtonText(
                                                                  "Cancel")
                                                              .setOnPressed(() {
                                                        Get.back();
                                                      }).build(context),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          AppFilledButtonWidget()
                                                              .setButtonText(
                                                                  "OK")
                                                              .setOnPressed(() {
                                                        if (selectedEntityRoom
                                                                ?.length !=
                                                            bookingModel
                                                                .numberOfRooms) {
                                                          AppSnackBarWidget()
                                                              .setAppSnackBarType(
                                                                  AppSnackBarType
                                                                      .toastMessage)
                                                              .setAppSnackBarStatus(
                                                                  AppSnackBarStatus
                                                                      .error)
                                                              .setContent(Text(
                                                                  "Please choose exactly ${bookingModel.numberOfRooms} rooms"))
                                                              .showSnackBar(
                                                                  context);
                                                        } else {
                                                          AppDefaultDialogWidget()
                                                              .setAppDialogType(
                                                                  AppDialogType
                                                                      .confirm)
                                                              .setNegativeText(
                                                                  "NO")
                                                              .setPositiveText(
                                                                  "YES")
                                                              .setTitle(
                                                                  "Confirm check-in")
                                                              .setOnPositive(
                                                                  () async {
                                                                await controller.updateCurrentBookingForMultipleEntityRooms(
                                                                    roomModel!
                                                                        .idRoom,
                                                                    selectedEntityRoom!
                                                                        .map((entityRoom) =>
                                                                            entityRoom.id)
                                                                        .toList(),
                                                                    bookingModel);
                                                                await controller
                                                                    .updateBookingIsCheckin(
                                                                        bookingModel
                                                                            .bookingId!,
                                                                        true);
                                                              })
                                                              .setContent(
                                                                  "Are you sure to choose these room for this booking?")
                                                              .buildDialog(
                                                                  context)
                                                              .show();
                                                        }
                                                      }).build(context),
                                                    )
                                                  ],
                                                )
                                              ]);
                                        },
                                      );
                                    }

                                    break;
                                  case 'check-in':
                                    print('check-in');
                                    AppDefaultDialogWidget()
                                        .setAppDialogType(AppDialogType.confirm)
                                        .setTitle("Confirm change status")
                                        .setContent(
                                            "Are you sure to change status to check-out?")
                                        .setPositiveText("Yes")
                                        .setNegativeText("No")
                                        .setOnPositive(() async {
                                          await controller
                                              .updateCurrentBookingForMultipleEntityRooms(
                                                  roomModel!.idRoom,
                                                  getEntityRoomIdByBooking(bookingModel),
                                                  null);
                                          await controller.updateBookingIsPaid(
                                              bookingModel.bookingId!, true);
                                        })
                                        .buildDialog(context)
                                        .show();
                                    break;
                                  case 'paid':
                                    print('paid');
                                    AppSnackBarWidget()
                                        .setContent(const Text(
                                            "You have already checked-out and paid"))
                                        .setAppSnackBarStatus(
                                            AppSnackBarStatus.info)
                                        .setAppSnackBarType(
                                            AppSnackBarType.toastMessage)
                                        .showSnackBar(Get.context!);
                                    break;
                                  case 'cancel':
                                    print('cancel');
                                    AppDefaultDialogWidget()
                                        .setAppDialogType(AppDialogType.confirm)
                                        .setTitle("Confirm change status")
                                        .setContent(
                                            "Are you sure to agree this cancel booking request? it's mean you will remove this booking")
                                        .setPositiveText("Yes")
                                        .setNegativeText("No")
                                        .setOnPositive(() async {
                                          await controller.deleteBooking(
                                              bookingModel.bookingId!);
                                        })
                                        .buildDialog(context)
                                        .show();
                                    break;
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 50,
                                color: AppColors.of.lightBlueColor[6],
                              )),
                          Column(
                            children: [
                              AppTextBody1Widget()
                                  .setText("NEXT STATUS")
                                  .setTextStyle(AppTextStyleExt.of.textBody1s)
                                  .setColor(AppColors.of.lightBlueColor[6])
                                  .build(context),
                              const SizedBox(
                                height: 12,
                              ),
                              _getBookingNextStatusIcon()
                            ],
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<String> getEntityRoomIdByBooking(BookingModel bookingModel) {
    List<String> listId = [];
    roomModel?.entityRoom?.forEach((element) {
      if (element?.currentBooking?.bookingId == bookingModel.bookingId) {
        listId.add(element!.id);
      }
    });
    return listId;
  }

  List<EntityRoomModel> listAvailableRoom(RoomModel roomModel) {
    List<EntityRoomModel> listEntityRoom = [];
    roomModel.entityRoom?.forEach((element) {
      if (element?.currentBooking == null) {
        listEntityRoom.add(element!);
      }
    });
    return listEntityRoom;
  }

  String _getStatus() {
    if (bookingModel.isCancelBooking == true) {
      return 'cancel';
    }
    if (bookingModel.isConfirm == false) {
      return 'waiting';
    } else if (bookingModel.isCheckIn == true) {
      if (bookingModel.isPaid == false) {
        return 'check-in';
      }
      return 'paid';
    }
    return 'confirm';
  }

  ImageIcon _getBookingNextStatusIcon() {
    if (bookingModel.isCancelBooking == true) {
      return ImageIcon(const AssetImage("assets/bookingStatus/cancel_icon.png"),
          size: 100, color: AppColors.of.redColor[5]);
    }
    if (bookingModel.isConfirm == false) {
      return ImageIcon(
        const AssetImage("assets/bookingStatus/confirm_icon.png"),
        size: 100,
        color: AppColors.of.greenColor[5],
      );
    } else if (bookingModel.isCheckIn == true) {
      if (bookingModel.isPaid == false) {
        return ImageIcon(
          const AssetImage("assets/bookingStatus/paid_icon.png"),
          size: 100,
          color: AppColors.of.lightBlueColor[7],
        );
      }
      return ImageIcon(
        const AssetImage("assets/bookingStatus/paid_icon.png"),
        size: 100,
        color: AppColors.of.lightBlueColor[7],
      );
    }
    return ImageIcon(
      const AssetImage("assets/bookingStatus/stay_icon.png"),
      size: 100,
      color: AppColors.of.lightBlueColor[5],
    );
  }

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
}
