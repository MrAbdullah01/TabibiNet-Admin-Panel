import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

import '../../../../Model/Res/Constants/app_fonts.dart';

class PatientStatusChart extends StatelessWidget {
  const PatientStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: "Patient Status",
            fontSize: 16.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor,
            fontFamily: AppFonts.semiBold,),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: bgColor,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 11,
                      minY: 0,
                      maxY: 200,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              const months = [
                                'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                              ];
                              return Text(
                                months[value.toInt()],
                                style: const TextStyle(fontFamily: AppFonts.regular),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontFamily: AppFonts.regular),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getRecoveredData(),
                          isCurved: true,
                          color: themeColor,
                          barWidth: 4,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.blue.withOpacity(0.3),
                          ),
                        ),
                        LineChartBarData(
                          spots: getDeathData(),
                          isCurved: true,
                          color: Colors.lightBlueAccent,
                          barWidth: 4,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.lightBlueAccent.withOpacity(0.3),
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((LineBarSpot touchedSpot) {
                              return LineTooltipItem(
                                '${touchedSpot.y.toInt()} \nSep 2024',
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {},
                        handleBuiltInTouches: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(2)
                      ),                    ),
                    SizedBox(width: .5.w,),
                    AppText(
                      text: "Recovered",
                      fontSize: 10.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,
                      fontFamily: AppFonts.medium,
                    ),
                    SizedBox(width: 3.w,),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(2)
                      ),
                    ),
                    SizedBox(width: .5.w,),
                    AppText(
                      text: "Death",
                      fontSize: 10.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,
                      fontFamily: AppFonts.medium,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> getRecoveredData() {
    return [
      const FlSpot(0, 100),
      const FlSpot(1, 120),
      const FlSpot(2, 150),
      const FlSpot(3, 170),
      const FlSpot(4, 180),
      const FlSpot(5, 140),
      const FlSpot(6, 135),
      const FlSpot(7, 150),
      const FlSpot(8, 160),
      const FlSpot(9, 120),
      const FlSpot(10, 140),
      const FlSpot(11, 160),
    ];
  }

  List<FlSpot> getDeathData() {
    return [
      const FlSpot(0, 50),
      const FlSpot(1, 70),
      const FlSpot(2, 100),
      const FlSpot(3, 130),
      const FlSpot(4, 140),
      const FlSpot(5, 120),
      const FlSpot(6, 135),
      const FlSpot(7, 140),
      const FlSpot(8, 120),
      const FlSpot(9, 90),
      const FlSpot(10, 110),
      const FlSpot(11, 130),
    ];
  }
}
