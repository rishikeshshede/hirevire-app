import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/custom_image_view.dart';
import 'package:hirevire_app/common/widgets/loader_circular_with_bg.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/user_interface/my_applications_tab/components/my_applications_card.dart';
import 'package:hirevire_app/utils/responsive.dart';

import 'controllers/my_applications_controller.dart';

class MyApplicationsTab extends StatelessWidget {
  const MyApplicationsTab({super.key});
  static final MyApplicationsController myApplicationsCard =
      Get.find(tag: 'myApplicationsCard');

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
      ),
      body: Obx(
        () {
          return myApplicationsCard.isLoading.value
              ? Container(
                  alignment: Alignment.center,
                  height: Responsive.height(context, 1),
                  child: const LoaderCircularWithBg(),
                )
              : myApplicationsCard.myApplications.isEmpty
                  ? const Center(
                      child: Text('No job applications available'),
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
                            myApplicationsCard.myApplications.length,
                            (index) => MyApplicationsCard(
                              index: index,
                              myApplicationsCard: myApplicationsCard,
                              myApplications:
                                  myApplicationsCard.myApplications[index],
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
