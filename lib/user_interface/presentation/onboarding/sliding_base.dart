import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/animated_progress_indicator.dart';
import 'package:hirevire_app/common/widgets/padded_container.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/user_interface/controllers/user_onb_controller.dart';

class SlidingBase extends GetWidget<UserOnbController> {
  const SlidingBase({super.key});

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      showBackIcon: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(),
          // --------------- Progress Indicator ---------------
          Obx(
            () => AnimatedProgressIndicator(
              value: (controller.currentProgressIndex.value + 1) /
                  controller.sectionWidgets().length,
            ),
          ),
          // --------------- Page Content ---------------
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentProgressIndex.value = index;
              },
              children: controller.sectionWidgets(),
            ),
          ),
        ],
      ),
    );
  }
}
