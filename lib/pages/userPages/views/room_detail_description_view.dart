import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/expansionPanel/app_expansion_panel_controller.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/toolTip/app_tooltip_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomDetailDescriptionView extends StatelessWidget {
  const RoomDetailDescriptionView(
      {super.key, required this.bodyDescription, required this.listConvenient});

  final Widget? bodyDescription;
  final List<ConvenientModel?>? listConvenient;

  List<Widget> _convertConvenient2Widget() {
    List<Widget> list = [];
    listConvenient?.forEach((element) {
      list.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getConvenientIcon(element!.nameConvenient),
          const SizedBox(height: 4.0),
          Text(element.nameConvenient),
        ],
      ));
    });
    return list;
  }

  ImageIcon _getConvenientIcon(String name) {
    switch (name) {
      case 'Air conditional':
        return const ImageIcon(
          AssetImage('assets/convenientsIcon/air_conditional_icon.png'),
          size: 50.0,
          color: Colors.blue,
        );
      case 'Washing machine':
        return const ImageIcon(
            AssetImage('assets/convenientsIcon/washing_machine_icon.png'),
            size: 50.0,
            color: Colors.blue);
      case 'Free wifi':
        return const ImageIcon(
            AssetImage('assets/convenientsIcon/free_wifi_icon.png'),
            size: 50.0,
            color: Colors.blue);
      case 'Free breakfast':
        return const ImageIcon(
            AssetImage('assets/convenientsIcon/free_breakfast_icon.png'),
            size: 50.0,
            color: Colors.blue);
      case 'Swimming pool':
        return const ImageIcon(
            AssetImage('assets/convenientsIcon/swimming_pool_icon.png'),
            size: 50.0,
            color: Colors.blue);
      case 'Gym':
        return const ImageIcon(
            AssetImage('assets/convenientsIcon/gym_icon.png'),
            size: 50.0,
            color: Colors.blue);
      default:
        return const ImageIcon(
            AssetImage('assets/convenientsIcon/default_convenient_icon.png'),
            size: 50.0,
            color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppExpansionPanelWidget(
                header: AppTextBody1Widget()
                    .setText("ROOM DESCRIPTION")
                    .setTextStyle(AppTextStyleExt.of.textBody1s)
                    .build(context),
                body: bodyDescription),
          ),
          Container(
            color: AppColors.of.grayColor[3],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextBody1Widget()
                    .setText("ROOM FACILITIES")
                    .setTextStyle(AppTextStyleExt.of.textBody1s)
                    .build(context),
                const SizedBox(
                  height: 8,
                ),
                StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  children: _convertConvenient2Widget(),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.room_outlined,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: AppTextBody1Widget()
                          .setText(
                              "19 Nguyen Huu Tho, Tan Phong Ward, District 7, HCMC")
                          .setMaxLines(3)
                          .setTextOverFlow(TextOverflow.ellipsis)
                          .build(context),
                    ),
                    AppTooltipWidget()
                        .setIcon(const Icon(Icons.info_outline_rounded))
                        .setPreferredDirection(AxisDirection.down)
                        .setText("Hotel location")
                        .build(context)
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_android,
                      color: Colors.blue,
                    ),
                    AppTextButtonWidget()
                        .setButtonText("+84 793 557 129")
                        .setOnPressed(() {
                      String phoneNumber = '+84793557129';
                      Uri uri = Uri.parse('tel:$phoneNumber');
                      launchUrl(uri);
                    }).build(context),
                    AppTooltipWidget()
                        .setIcon(const Icon(Icons.info_outline_rounded))
                        .setPreferredDirection(AxisDirection.down)
                        .setText("Call to schedule check-in and check-out times")
                        .build(context)
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            child: Column(
              children: [
                Row(
                  children: [

                  ],
                ),
                Row()
              ],
            ),
          )
        ],
      ),
    );
  }
}
