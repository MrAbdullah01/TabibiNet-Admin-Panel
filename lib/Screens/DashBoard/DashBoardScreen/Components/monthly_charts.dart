import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartSample1 extends StatefulWidget {
  final Map<String, int> userCounts;

  BarChartSample1({
    super.key,
    required this.userCounts,
  });

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 116,
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
                "Monthly Patients",

              )
            ],
          ),
          AspectRatio(
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
                  barGroups: _buildBarChartData(widget.userCounts),
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build bar chart data from user counts
  List<BarChartGroupData> _buildBarChartData(Map<String, int> counts) {
    // Define all 12 months initialized to 0
    Map<String, int> allMonths = {
      'Jan': 0,
      'Feb': 0,
      'Mar': 0,
      'Apr': 0,
      'May': 0,
      'Jun': 0,
      'Jul': 0,
      'Aug': 0,
      'Sep': 0,
      'Oct': 0,
      'Nov': 0,
      'Dec': 0,
    };

    counts.forEach((month, count) {
      String monthAbbreviation = month.substring(0, 3);
      if (allMonths.containsKey(monthAbbreviation)) {
        allMonths[monthAbbreviation] = count;
      }
    });

    // Create BarChartGroupData from allMonths
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    allMonths.forEach((month, count) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.blue, // Customize bar color
              width: 16, // Width of the bars
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

Future<Map<String, int>> getUserCountByMonth() async {
  Map<String, int> userCountByMonth = {};

  QuerySnapshot snapshot =
  await FirebaseFirestore.instance.collection('users').get();

  for (var doc in snapshot.docs) {
    Timestamp joinDateTimestamp = doc['joinDate'];
    DateTime joinDate = joinDateTimestamp.toDate();
    String formattedDate = DateFormat('MMMM yyyy').format(joinDate);

    if (userCountByMonth.containsKey(formattedDate)) {
      userCountByMonth[formattedDate] = userCountByMonth[formattedDate]! + 1;
    } else {
      userCountByMonth[formattedDate] = 1;
    }
  }

  return userCountByMonth;
}