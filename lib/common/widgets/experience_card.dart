import 'package:flutter/material.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/constants/global_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/responsive.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onDelete,
  });

  final Map<String, dynamic> experience;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(context, 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience['title']['name'],
                      style: AppTextThemes.subtitleStyle(context).copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          experience['company']['name'],
                          style: AppTextThemes.subtitleStyle(context).copyWith(
                            fontSize: 14,
                          ),
                        ),
                        if (experience['employmentType'] != null)
                          Text(
                            " • ${experience['employmentType']}",
                            style:
                                AppTextThemes.subtitleStyle(context).copyWith(
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      getFormattedDates(
                        experience['startDate'],
                        experience['endDate'],
                        experience['stillWorking'],
                      ),
                      style: AppTextThemes.bodyTextStyle(context).copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Row(
                      children: [
                        if (experience['location']['country'] != '')
                          Text(
                            experience['location']['country'],
                            style:
                                AppTextThemes.bodyTextStyle(context).copyWith(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        if (experience['jobMode'] != null)
                          Text(
                            " • ",
                            style:
                                AppTextThemes.bodyTextStyle(context).copyWith(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        if (experience['jobMode'] != null)
                          Text(
                            "${experience['jobMode']}",
                            style:
                                AppTextThemes.bodyTextStyle(context).copyWith(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    const VerticalSpace(),
                    if (experience['description'] != '')
                      Text(
                        experience['description'],
                        style: AppTextThemes.subtitleStyle(context).copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onDelete, // show warning
                child: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
              ),
            ],
          ),
          const Divider(height: 30),
        ],
      ),
    );
  }

  getFormattedDates(String startDate, String? endDate, bool stillWorking) {
    DateTime startDateTime = DateTime.parse(startDate);
    DateTime? endDateTime =
        endDate == null ? DateTime.now() : DateTime.parse(endDate);

    String startDateStr = getDate(startDateTime);
    String endDateStr = getEndDate(endDateTime, stillWorking);

    return "$startDateStr - $endDateStr";
  }

  String getDate(DateTime date) {
    int month = date.month;
    String monthStr = '';
    for (var entry in GlobalConstants.monthsMap.entries) {
      if (entry.value == month) {
        monthStr = entry.key;
      }
    }

    String dateStr = '$monthStr ${date.year}';
    return dateStr;
  }

  getEndDate(DateTime? date, bool stillWorking) {
    if (stillWorking) {
      return 'Present';
    } else {
      return getDate(date!);
    }
  }
}
