import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pms_dashboard/widgets/reservation_forecast_widgets/date_range_widget.dart';

class ReservationForecast extends StatefulWidget {
  @override
  _ReservationForecastState createState() => _ReservationForecastState();
}

class _ReservationForecastState extends State<ReservationForecast> {
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now().add(Duration(days: 1));
  DateTime date3 = DateTime.now().add(Duration(days: 2));
  Map<String, Map<String, String>> forecastData = {};

  @override
  void initState() {
    super.initState();
    fetchReservationForecastData();
  }

  Future<void> fetchReservationForecastData() async {
    final fromDate = DateFormat('dd-MMM-yy').format(date1);
    final toDate = DateFormat('dd-MMM-yy').format(date3);
    final url = 'http://192.168.0.101:7143/api/ReservationForecast/GetReservationForecastData?fromDate=$fromDate&toDate=$toDate';

    print('Fetching data from: $url');

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('API response: $data');
        setState(() {
          forecastData = {
            for (var item in data) item['PARTICULARS']: item.map((key, value) => MapEntry(key, value.toString()))
          };
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      date2 = selectedDate;
      date3 = selectedDate.add(Duration(days: 1));
      fetchReservationForecastData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateRangeWidget(onDateSelected: _onDateSelected),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FixedColumnWidth(60.0),
                    2: FixedColumnWidth(60.0),
                  },
                  border: TableBorder.all(color: Colors.white24),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: _buildTableRows(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TableRow> _buildTableRows() {
    List<TableRow> rows = [
      TableRow(
        children: [
          _buildCell("Particulars"),
          _buildCell(DateFormat('MMM d').format(date2)),
          _buildCell(DateFormat('MMM d').format(date3)),
        ],
      ),
    ];

    List<String> particulars = [
      "Park Suite",
      "Premium",
      "Deluxe",
      "Deluxe Twin",
      "Total Rooms",
      "Saleable Rooms",
      "Confirmed Rooms",
      "Unconfirmed Rooms",
      "Total Occupied Rooms",
      "Available Rooms for the Day",
      "Occupancy Percentage"
    ];

    particulars.forEach((particular) {
      rows.add(TableRow(
        children: [
          _buildCell(particular, alignment: Alignment.centerLeft),
          _buildCell(forecastData[particular]?['D02'] ?? 'N/A'),
          _buildCell(forecastData[particular]?['D03'] ?? 'N/A'),
        ],
      ));
    });

    return rows;
  }

  Widget _buildCell(String text, {AlignmentGeometry alignment = Alignment.center}) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
