import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pms_dashboard/conostants.dart';
import 'package:pms_dashboard/models/chart_spline_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyOccupancyOverview extends StatefulWidget {
  const DailyOccupancyOverview({
    Key? key,
  }) : super(key: key);

  @override
  _DailyOccupancyOverviewState createState() => _DailyOccupancyOverviewState();
}

class _DailyOccupancyOverviewState extends State<DailyOccupancyOverview> {
  late List<ChartSplineData> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
      'https://localhost:7143/Api/WebDashboard/GetDailyOccupancy?fromDate=01-jan-24&toDate=30-Mar-24',
    ));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        chartData = jsonData.map((data) {
          return ChartSplineData(
            date: data['clM02'].toString(), // Assuming 'clM02' represents the date
            roomSell: data['clM11'].toDouble(), // Assuming 'clM11' represents room sell
            pax: data['clM12'].toDouble(), // Assuming 'clM12' represents PAX
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      height: 250,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            "Daily Occupancy Overview",
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8,),
          Expanded(
            child: chartData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: EdgeInsets.all(0),
              borderWidth: 0,
              primaryXAxis: CategoryAxis(
                axisLine: AxisLine(width: 0),
                labelPlacement: LabelPlacement.onTicks,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: AxisLine(width: 0),
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(width: 0),
              ),
              series: [
                SplineSeries<ChartSplineData, String>(
                  color: Color(0xFF9644FF),
                  width: 2,
                  dataSource: chartData,
                  xValueMapper: (ChartSplineData data, _) => data.date,
                  yValueMapper: (ChartSplineData data, _) => data.pax,
                ),
                SplineAreaSeries<ChartSplineData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartSplineData data, _) => data.date,
                  yValueMapper: (ChartSplineData data, _) => data.roomSell,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF342C9C),
                      Color(0xFF342C9C).withAlpha(23),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
