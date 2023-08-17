// part of 'app_dialog_base_builder.dart';
//
// class AppDialogSecondTypeWidget extends AppDialogBaseBuilder {
//
//   @override
//   AppDialogSecondTypeWidget setTitle(String? title) {
//     _title = title;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setContentWidget(Widget? contentWidget) {
//     _contentWidget = contentWidget;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setIcon(Widget? icon) {
//     _icon = icon;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setPositiveText(String? positiveText) {
//     _positiveText = positiveText;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setNegativeText(String? negativeText) {
//     _negativeText = negativeText;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setOnPositive(void Function()? onPositive) {
//     _onPositive = onPositive;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setOnNegative(void Function()? onNegative) {
//     _onNegative = onNegative;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setAppDialogType(AppDialogType? type) {
//     _appDialogType = type;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setTextField(Widget? textField) {
//     _textField = textField;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setAppDialogButtonType(
//       AppDialogButtonType? appDialogButtonType) {
//     _appDialogButtonType = appDialogButtonType;
//     return this;
//   }
//
//   @override
//   AppDialogSecondTypeWidget setIsHaveCloseIcon(bool? isHaveCloseIcon) {
//     _isHaveCloseIcon = isHaveCloseIcon;
//     return this;
//   }
//
//   @override
//   AppDialogBaseBuilder buildDialog(BuildContext context) {
//     if (_appDialogType == AppDialogType.error) {
//       setIcon(R.svgs.icErrorOnDialog.svg());
//     }
//     if (_appDialogType == AppDialogType.success) {
//       setIcon(R.svgs.icSuccessOnDialog.svg());
//     }
//     if (_appDialogType == AppDialogType.confirm) {
//       setIcon(R.svgs.icConfirmOnDialog.svg());
//     }
//     _dialog = Dialog(
//       insetPadding: EdgeInsets.all(AppThemeExt.of.majorScale(6)),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(AppThemeExt.of.majorScale(3)),
//               color: AppColors.of.grayColor[1],
//             ),
//             padding: EdgeInsets.all(AppThemeExt.of.majorScale(6)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: AppThemeExt.of.majorScale(2)),
//                 if (_icon != null) _icon!,
//                 if (_title != null)
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         vertical: AppThemeExt.of.majorScale(3)),
//                     child: AppTextHeading3Widget()
//                         .setTextAlign(TextAlign.center)
//                         .setText(_title)
//                         .build(context),
//                   ),
//                 if (_contentWidget != null) _contentWidget!,
//                 SizedBox(height: AppThemeExt.of.majorScale(6)),
//                 if (_textField != null) _textField!,
//                 if (_textField != null)
//                   SizedBox(height: AppThemeExt.of.majorScale(6)),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     if (_negativeText != null)
//                       Expanded(
//                         child: AppOutlinedButtonWidget()
//                             .setAppButtonSize(AppButtonSize.large)
//                             .setButtonText(_negativeText)
//                             .setOnPressed(() {
//                           Get.back();
//                           _onNegative?.call();
//                         }).build(context),
//                       ),
//                     if (_negativeText != null)
//                       SizedBox(width: AppThemeExt.of.majorScale(3)),
//                     if (_positiveText != null)
//                       _appDialogButtonType == AppDialogButtonType.danger
//                           ? Expanded(
//                               child: AppFilledButtonWidget()
//                                   .setAppButtonSize(AppButtonSize.large)
//                                   .setButtonText(_positiveText)
//                                   .setAppButtonType(AppButtonType.danger)
//                                   .setOnPressed(() {
//                                 Get.back();
//                                 _onPositive?.call();
//                               }).build(context),
//                             )
//                           : Expanded(
//                               child: AppFilledButtonWidget()
//                                   .setAppButtonSize(AppButtonSize.large)
//                                   .setButtonText(_positiveText)
//                                   .setOnPressed(() {
//                                 Get.back();
//                                 _onPositive?.call();
//                               }).build(context),
//                             ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           _isHaveCloseIcon == true
//               ? Positioned(
//                   right: 0.0,
//                   child: IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       }),
//                 )
//               : const SizedBox()
//         ],
//       ),
//     );
//     return this;
//   }
// }
