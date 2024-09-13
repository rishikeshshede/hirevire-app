import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class RadarChartComponent extends StatelessWidget {
  final List<RadarEntry> jobPostData;
  final List<RadarEntry> applicantData;
  final List<String>? skillNames;

  const RadarChartComponent({
    super.key,
    required this.jobPostData,
    required this.applicantData,
    required this.skillNames,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: RadarChart(
        RadarChartData(
          radarTouchData: RadarTouchData(enabled: true),
          dataSets: [
            RadarDataSet(
              fillColor: Colors.blue.withOpacity(1),
              borderColor: Colors.blue,
              borderWidth: 2,
              entryRadius: 2,
              dataEntries: jobPostData,
            ),
            RadarDataSet(
              fillColor: Colors.orange.withOpacity(0.2),
              borderColor: Colors.orange,
              borderWidth: 2,
              entryRadius: 2,
              dataEntries: applicantData,
            ),
          ],
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.transparent),
          titlePositionPercentageOffset: 0.1,
          titleTextStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          radarShape: RadarShape.circle,
          getTitle: (index, angle) {
            if (skillNames != null && index < skillNames!.length) {
              if (skillNames![index].startsWith('Dummy Skill')) {
                return RadarChartTitle(
                    text: '', angle: angle); // Skip dummy skill title
              }
              return RadarChartTitle(
                text: skillNames![index],
                angle: angle,
              );
            }
            return RadarChartTitle(text: '', angle: angle);
          },
        ),
      ),
    );
  }
}