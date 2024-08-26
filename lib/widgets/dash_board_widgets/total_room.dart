import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pms_dashboard/conostants.dart';

class TotalRoomsItem extends StatefulWidget {

  final DateTime? fromDate;
  final DateTime? toDate;

  TotalRoomsItem({this.fromDate, this.toDate});

  @override
  _TotalRoomsItemState createState() => _TotalRoomsItemState();
}

class _TotalRoomsItemState extends State<TotalRoomsItem> {
  String totalRoomsYTD = '';
  String totalRoomsMTD = '';
  String totalRoomsToday = '';
  bool isLoading = true;
  String noDataMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant TotalRoomsItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fromDate != widget.fromDate ||
        oldWidget.toDate != widget.toDate) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      noDataMessage = '';
    });

    final String url;
    if (widget.fromDate == null || widget.toDate == null) {
      // Fetch all-time data if no date range is selected
      url = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0134';
    } else {
      // Fetch data for the selected date range
      final DateTime fromDate = widget.fromDate!;
      final DateTime toDate = widget.toDate!;
      final String formattedFromDate = DateFormat('dd-MMM-yy').format(fromDate);
      final String formattedToDate = DateFormat('dd-MMM-yy').format(toDate);

      url = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0134&clm03=$formattedToDate';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response data: $data');
      setState(() {
        if (data.isEmpty) {
          noDataMessage = 'No data available for the selected date range.';
        } else {
          totalRoomsYTD = data['clM09'].toString();
          totalRoomsMTD = data['clM12'].toString();
          totalRoomsToday = data['clM06'].toString();
        }
        isLoading = false;
      });
    } else if (response.statusCode == 204) {
      setState(() {
        noDataMessage = 'No data available.';
        isLoading = false;
      });
    } else {
      print('Failed to load data with status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL ROOMS",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    "assets/icons/roomsavailable.png",
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$totalRoomsYTD:YTD",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$totalRoomsMTD:MTD",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$totalRoomsToday:Today",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
