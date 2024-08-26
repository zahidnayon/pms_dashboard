import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pms_dashboard/conostants.dart';

class OccupiedRoomsItem extends StatefulWidget {

  final DateTime? fromDate;
  final DateTime? toDate;

  OccupiedRoomsItem({this.fromDate, this.toDate});


  @override
  _OccupiedRoomsItemState createState() => _OccupiedRoomsItemState();
}

class _OccupiedRoomsItemState extends State<OccupiedRoomsItem> {
  String occupiedRoomsYTD = '';
  String occupiedRoomsMTD = '';
  String occupiedRoomsToday = '';
  bool isLoading = true;
  String noDataMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant OccupiedRoomsItem oldWidget) {
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

    final DateTime fromDate = widget.fromDate ?? DateTime.now();
    final DateTime toDate = widget.toDate ?? DateTime.now();
    final String formattedFromDate = DateFormat('dd-MMM-yy').format(fromDate);
    final String formattedToDate = DateFormat('dd-MMM-yy').format(toDate);

    final String url;
    if (widget.fromDate == null || widget.toDate == null) {
      // Fetch all-time data if no date range is selected
      url =
      'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0101';
    } else {
      // Fetch data for the selected date range
      url =
      'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0101&clm03=$formattedToDate';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response data: $data');
      setState(() {
        if (data.isEmpty) {
          noDataMessage = 'No data available for the selected date range.';
        } else {
          occupiedRoomsYTD = data['clM09'].toString();
          occupiedRoomsMTD = data['clM12'].toString();
          occupiedRoomsToday = data['clM06'].toString();
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

  // Future<void> fetchData() async {
  //   final Uri url = Uri.parse('http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0101');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       occupiedRoomsYTD = data['clM09'].toString();
  //       occupiedRoomsMTD = data['clM12'].toString();
  //       occupiedRoomsToday = data['clM06'].toString();
  //       isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

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
                    "OCCUPIED ROOMS",
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
                children: [
                  Row(
                    children: [
                      // number value with circular progress indicators
                      isLoading
                          ? CircularProgressIndicator() // Show indicator while loading
                          :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            parseOccupiedRoomsYTD(),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            parseOccupiedRoomsMTD(),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            parseOccupiedRoomsToday(),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // ":"
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "  :  ",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            "  :  ",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 6,),
                          Text(
                            "  :  ",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      //YTD,MTD,Today
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "YTD",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            "MTD",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            "Today",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String parseOccupiedRoomsYTD() {
    try {
      // Remove non-numeric characters and parse double
      final doubleValue = double.parse(occupiedRoomsYTD.replaceAll(RegExp(r'[^0-9.]'), ''));
      // Format double value with NumberFormat
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

  String parseOccupiedRoomsMTD() {
    try {
      // Remove non-numeric characters and parse double
      final doubleValue = double.parse(occupiedRoomsMTD.replaceAll(RegExp(r'[^0-9.]'), ''));
      // Format double value with NumberFormat
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

  String parseOccupiedRoomsToday() {
    try {
      // Remove non-numeric characters and parse double
      final doubleValue = double.parse(occupiedRoomsToday.replaceAll(RegExp(r'[^0-9.]'), ''));
      // Format double value with NumberFormat
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

}
