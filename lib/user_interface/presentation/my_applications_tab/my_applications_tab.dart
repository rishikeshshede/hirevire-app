import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirevire_app/common/widgets/loader_circular_with_bg.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/utils/responsive.dart';

import 'components/my_applications_card.dart';
import 'controllers/my_applications_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hirevire_app/common/widgets/button_primary.dart';
import 'package:hirevire_app/themes/text_theme.dart';

class MyApplicationsTab extends StatelessWidget {
  const MyApplicationsTab({super.key});
  static final MyApplicationsController myApplicationsController =
      Get.find(tag: 'myApplicationsController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            return myApplicationsController.isLoading.value
                ? Container(
                    alignment: Alignment.center,
                    height: Responsive.height(context, 1),
                    child: const LoaderCircularWithBg(),
                  )
                : Container(
                    width: Responsive.width(context, 1),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.gradientProfielCard,
                        stops: AppColors.gradientPrimaryStops,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Filter
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Application Status',
                                style: AppTextThemes.subtitleStyle(context),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: DraggableScrollableSheet(
                                          builder: (_, scrollController) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 12),
                                              decoration: const BoxDecoration(
                                                color: AppColors.background,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(25.0),
                                                  topRight:
                                                      Radius.circular(25.0),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 15),
                                                  Text(
                                                    "Status",
                                                    style: AppTextThemes
                                                            .subtitleStyle(
                                                                context)
                                                        .copyWith(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                        GlobalConstants
                                                            .statusList.length,
                                                        (index) {
                                                          final specialization =
                                                              GlobalConstants
                                                                      .statusList[
                                                                  index];
                                                          return Obx(() {
                                                            RxBool isSelected =
                                                                myApplicationsController
                                                                    .selectedSpecializations
                                                                    .contains(
                                                                        specialization)
                                                                    .obs;

                                                            return ListTile(
                                                              title: Text(
                                                                  specialization),
                                                              trailing: Theme(
                                                                data: ThemeData(
                                                                  unselectedWidgetColor:
                                                                      AppColors
                                                                          .disabled,
                                                                ),
                                                                child: Checkbox(
                                                                  value:
                                                                      isSelected
                                                                          .value,
                                                                  checkColor:
                                                                      AppColors
                                                                          .primary,
                                                                  activeColor:
                                                                      AppColors
                                                                          .primaryDark,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                    side: isSelected
                                                                            .value
                                                                        ? const BorderSide(
                                                                            color: AppColors
                                                                                .primary,
                                                                            width:
                                                                                1)
                                                                        : const BorderSide(
                                                                            color:
                                                                                AppColors.disabled,
                                                                            width: 1),
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    myApplicationsController
                                                                        .toggleSpecialization(
                                                                            specialization);
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height: Responsive.height(
                                                          context, .07),
                                                      width: double.infinity,
                                                      color:
                                                          AppColors.background,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                myApplicationsController
                                                                    .clearFilters();
                                                                Get.back();
                                                                await myApplicationsController
                                                                    .fetchMyApplications();
                                                              },
                                                              child: Text(
                                                                'Clear All',
                                                                style: AppTextThemes
                                                                        .buttonTextStyle(
                                                                            context)
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child:
                                                                ButtonPrimary(
                                                              btnText: 'Apply',
                                                              onPressed:
                                                                  () async {
                                                                Get.back();
                                                                await myApplicationsController
                                                                    .applyFilter();
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/filter.svg',
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primary.withOpacity(.6),
                                        BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // List of Applications
                        Obx(() {
                          return myApplicationsController.myApplications.isEmpty
                              ? const Center(
                                  child: Text('No job applications available'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                      myApplicationsController
                                          .myApplications.length,
                                      (index) => MyApplicationsCard(
                                        index: index,
                                        myApplicationsController:
                                            myApplicationsController,
                                        myApplications: myApplicationsController
                                            .myApplications[index],
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
