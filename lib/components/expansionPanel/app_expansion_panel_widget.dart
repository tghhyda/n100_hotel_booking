part of 'app_expansion_panel_controller.dart';

class AppExpansionPanelWidget extends GetView<AppExpansionPanelController> {
  final Widget? header;
  final Widget? body;

  @override
  AppExpansionPanelController get controller =>
      Get.put(AppExpansionPanelController());

  const AppExpansionPanelWidget({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            controller.toggleExpand();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: AppThemeExt.of.majorPaddingScale(3),
              horizontal: AppThemeExt.of.majorPaddingScale(0),
            ),
            color: AppColors.of.whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                header ?? const SizedBox(),
                Obx(
                  () => controller.isExpanded.value == true
                      ? const Icon(Icons.keyboard_arrow_up)
                      : const Icon(Icons.keyboard_arrow_down)
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 100),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppThemeExt.of.majorPaddingScale(4),
            ),
            color: AppColors.of.whiteColor,
            child: Obx(
              () => controller.isExpanded.value == true
                  ? Padding(
                      padding: EdgeInsets.only(
                        bottom: AppThemeExt.of.majorPaddingScale(4),
                      ),
                      child: body ?? const SizedBox(),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
