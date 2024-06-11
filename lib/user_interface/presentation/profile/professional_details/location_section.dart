import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/body_text_widget.dart';
import 'package:hirevire_app/common/widgets/button_circular.dart';
import 'package:hirevire_app/common/widgets/dropdown_widget.dart';
import 'package:hirevire_app/common/widgets/heading_large.dart';
import 'package:hirevire_app/common/widgets/loader_circular.dart';
import 'package:hirevire_app/common/widgets/text_field.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/constants/image_constants.dart';
import 'package:hirevire_app/user_interface/controllers/profile_controller.dart';
import 'package:hirevire_app/utils/size_util.dart';

class LocationSection extends GetWidget<ProfileController> {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingLarge(heading: "Your Location Preference"),
                SizedBox(height: 10.h(context)),
                const BodyTextWidget(
                    text: "Select your preferred mode of working"),
                SizedBox(height: 30.h(context)),
                Obx(
                  () => DropdownWidget(
                    controller: controller,
                    title: 'Job mode',
                    list: GlobalConstants.locationTypes,
                    initialValue: controller.preferredJobMode.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.preferredJobMode.value = value;
                      }
                    },
                  ),
                ),
                SizedBox(height: 15.h(context)),
                CustomTextField(
                    titleText: "Your Location",
                    labelText: 'Ex: Pune, India',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: controller.locationController,
                    focusNode: controller.locationFocusNode,
                    onChanged: (String value) {
                      // search for location
                    },
                    onEditingComplete: () {
                      controller.locationFocusNode.unfocus();
                    }),
              ],
            ),
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              controller.isSigningUp.value
                  ? const LoaderCircular()
                  : ButtonCircular(
                      icon: ImageConstant.tickIcon,
                      onPressed: () {
                        controller.signup();
                      },
                      isActive: true,
                    ),
            ],
          ),
        ),
        SizedBox(height: 16.h(context)),
      ],
    );
  }
}
