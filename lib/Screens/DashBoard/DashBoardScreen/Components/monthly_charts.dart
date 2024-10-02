import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../Provider/userCounter/userCountProvider.dart';

class BarChartSample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserCountProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: 30.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Monthly Users",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
                width: 100.w,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: getTitlesWidget,
                              reservedSize: 38,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: _buildBarChartData(provider.userCounts),
                        gridData: const FlGridData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
              if (provider.isLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Loading data...",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _buildBarChartData(Map<String, int> counts) {
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    counts.forEach((month, count) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.blue,
              width: 16,
            ),
          ],
        ),
      );
      index++;
    });

    return barGroups;
  }

  Widget getTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final titles = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final text = value.toInt() < titles.length
        ? Text(titles[value.toInt()], style: style)
        : const Text('', style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
