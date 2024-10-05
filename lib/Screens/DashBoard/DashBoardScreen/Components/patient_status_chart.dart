import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PatientCountLineChart extends StatefulWidget {
  @override
  _PatientCountLineChartState createState() => _PatientCountLineChartState();
}

class _PatientCountLineChartState extends State<PatientCountLineChart> {
  Future<List<int>> getPatientCounts() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    List<int> counts = [];

    try {
      for (int monthOffset = 0; monthOffset < 12; monthOffset++) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('userType', isEqualTo: 'Patient')
            // .where('createdAt', isGreaterThan: DateTime.now().subtract(Duration(days: monthOffset * 30))) // Adjust as necessary
            .get();

        counts.add(querySnapshot.docs.length);
      }
    } catch (e) {
      print('Error fetching patient counts: $e');
    }

    return counts.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: getPatientCounts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        }

        List<int> patientCounts = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                'Monthly Patient Counts',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 2,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            const titles = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                            return Text(titles[value.toInt()]); // Return the month name
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(patientCounts.length, (index) => FlSpot(index.toDouble(), patientCounts[index].toDouble())),
                        isCurved: true,
                        color: Colors.blue,
                        belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
