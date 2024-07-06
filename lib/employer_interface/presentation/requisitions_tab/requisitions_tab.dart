import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/components/requisitions_card.dart';

import 'controllers/requisitions_controller.dart';


class RequisitionsTab extends StatelessWidget {
  const RequisitionsTab({super.key});
  static final RequisitionsController jobsController = Get.find(tag: 'requisitionsController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: Obx(
          () => CustomImageView(
            imagePath: "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
            height: 18,
            imageType: ImageType.network,
            showLoader: false,
          ),
        ),
        actions: [
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     margin: EdgeInsets.only(
          //         right: GlobalConstants.screenHorizontalPadding),
          //     padding: const EdgeInsets.all(3),
          //     height: 35,
          //     width: 35,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.settingsIcon,
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                  right: GlobalConstants.screenHorizontalPadding),
              padding: const EdgeInsets.all(3),
              height: 35,
              width: 35,
              child: CustomImageView(
                imagePath: ImageConstant.userIcon,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
          return
            jobsController.requisitions.value.isEmpty
          ?
            const Center(
                    child: Text('No requisitions available'),
            )
          :
            Stack(
              children: List.generate(
                jobsController.requisitions.length,
                    (index) => RequisitionsCard(
                  index: index, requisitionsController: jobsController,
                  requisition: jobsController.requisitions[index],
                ),
              ),
            );
        },
      ),
    );
  }
}
