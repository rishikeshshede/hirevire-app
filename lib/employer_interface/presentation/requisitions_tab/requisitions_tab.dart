import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/loader_circular_with_bg.dart';
import 'package:hirevire_app/common/widgets/profile_logout.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/employer_interface/presentation/requisitions_tab/components/requisitions_card.dart';
import 'package:hirevire_app/utils/responsive.dart';

import 'controllers/requisitions_controller.dart';

class RequisitionsTab extends StatelessWidget {
  const RequisitionsTab({super.key});
  static final RequisitionsController requisitionsController =
      Get.find(tag: 'requisitionsController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: const CustomImageView(
          imagePath:
              "https://banner2.cleanpng.com/20190417/sxw/kisspng-microsoft-windows-portable-network-graphics-logo-t-aevinel-reino-maldito-descarga-5cb6fb279ba648.3641279715554957196376.jpg",
          height: 35,
          imageType: ImageType.network,
          showLoader: false,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              ProfileLogout.logout(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                  right: GlobalConstants.screenHorizontalPadding),
              padding: const EdgeInsets.all(3),
              height: 35,
              width: 35,
              child: CustomImageView(
                color: AppColors.primaryDark,
                imagePath: ImageConstant.logout,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          return requisitionsController.isLoading.value
              ? Container(
                  alignment: Alignment.center,
                  height: Responsive.height(context, 1),
                  child: const LoaderCircularWithBg(),
                )
              : requisitionsController.requisitions.isEmpty
                  ? const Center(
                      child: Text('No requisitions available'),
                    )
                  : Container(
                      width: Responsive.width(context, 1),
                      height: Responsive.height(context, 1),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: AppColors.gradientProfielCard,
                          stops: AppColors.gradientPrimaryStops,
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalConstants.screenHorizontalPadding * .75),
                        child: Column(
                          children: List.generate(
                            requisitionsController.requisitions.length,
                            (index) => RequisitionsCard(
                              index: index,
                              requisitionsController: requisitionsController,
                              requisition:
                                  requisitionsController.requisitions[index],
                            ),
                          ),
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
