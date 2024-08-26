import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pms_dashboard/conostants.dart';

class BarChart extends StatelessWidget {
  final List<BarChartData> data;

  const BarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxValue =
    data.map((e) => e.pax).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Monthly Occupancy Overview",
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 300, // Adjust the height of the chart as needed
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: data.map((e) {
                  final barHeight = (e.pax / maxValue) * 200;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '\ ${e.pax.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 32,
                        height: barHeight,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 8),
                      Text(
                        e.month,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartData {
  final String month;
  final double pax;

  BarChartData({required this.month, required this.pax});
}

// Sample data for the BarChart
List<BarChartData> barChartData = [
  BarChartData(month: "Jan", pax: 500),
  BarChartData(month: "Feb", pax: 700),
  BarChartData(month: "Mar", pax: 900),
  BarChartData(month: "Apr", pax: 600),
  BarChartData(month: "May", pax: 800),
  BarChartData(month: "Jun", pax: 500),
  BarChartData(month: "Jul", pax: 900),
  BarChartData(month: "Aug", pax: 300),
  BarChartData(month: "Sep", pax: 600),
  BarChartData(month: "Oct", pax: 400),
  BarChartData(month: "Nov", pax: 700),
  BarChartData(month: "Dec", pax: 200),
];
