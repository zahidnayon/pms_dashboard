import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pms_dashboard/conostants.dart';

class HotRevParItem extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  HotRevParItem({this.fromDate, this.toDate});

  @override
  State<HotRevParItem> createState() => _HotRevParItemState();
}

class _HotRevParItemState extends State<HotRevParItem> {
  String occupiedRoomsYTD = '';
  String occupiedRoomsMTD = '';
  String occupiedRoomsToday = '';

  String revenueParYTD = '';
  String revenueParMTD = '';
  String revenueParToday = '';
  bool isLoading = true;
  String noDataMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataRevenuePar();
  }

  @override
  void didUpdateWidget(covariant HotRevParItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fromDate != widget.fromDate || oldWidget.toDate != widget.toDate) {
      fetchData();
      fetchDataRevenuePar();
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
      url =
      'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0101';
    } else {
      // Fetch data for the selected date range
      final String formattedFromDate = DateFormat('dd-MMM-yy').format(widget.fromDate!);
      final String formattedToDate = DateFormat('dd-MMM-yy').format(widget.toDate!);

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

  Future<void> fetchDataRevenuePar() async {
    setState(() {
      isLoading = true;
      noDataMessage = '';
    });

    final String url;
    if (widget.fromDate == null || widget.toDate == null) {
      // Fetch all-time data if no date range is selected
      url =
      'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0106';
    } else {
      // Fetch data for the selected date range
      final String formattedFromDate = DateFormat('dd-MMM-yy').format(widget.fromDate!);
      final String formattedToDate = DateFormat('dd-MMM-yy').format(widget.toDate!);

      url =
      'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0106&clm03=$formattedToDate';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response data: $data');
      setState(() {
        if (data.isEmpty) {
          noDataMessage = 'No data available for the selected date range.';
        } else {
          revenueParYTD = data['clM09'].toString();
          revenueParMTD = data['clM12'].toString();
          revenueParToday = data['clM06'].toString();
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

  double calculateDivision(String occupiedRooms, String revenuePar) {
    int occupiedRoomsInt = int.tryParse(occupiedRooms) ?? 0;
    int revenueParInt = int.tryParse(revenuePar) ?? 0;
    // Ensure that revenuePar is not 0 to avoid division by zero error
    if (revenueParInt != 0) {
      return revenueParInt / occupiedRoomsInt;
    } else {
      // Handle the case where revenuePar is 0
      return double.infinity; // or any value to indicate division by zero
    }
  }

  @override
  Widget build(BuildContext context) {
    double divisionYTD = calculateDivision(occupiedRoomsYTD, revenueParYTD);
    double divisionMTD = calculateDivision(occupiedRoomsMTD, revenueParMTD);
    double divisionToday = calculateDivision(occupiedRoomsToday, revenueParToday);

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
                    "Hot REV PAR",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    "assets/icons/revpar.png",
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
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            parseDivisionYTD(),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            parseDivisionMTD(),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            parseDivisionToday(),
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

  String parseDivisionYTD() {
    try {
      // Calculate divisionYTD here
      double divisionYTD = calculateDivision(occupiedRoomsYTD, revenueParYTD);
      // Remove non-numeric characters and format double value with NumberFormat
      return NumberFormat('#,##0.00').format(divisionYTD);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

  String parseDivisionMTD() {
    try {
      // Calculate divisionMTD here
      double divisionMTD = calculateDivision(occupiedRoomsMTD, revenueParMTD);
      // Remove non-numeric characters and format double value with NumberFormat
      return NumberFormat('#,##0.00').format(divisionMTD);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

  String parseDivisionToday() {
    try {
      // Calculate divisionToday here
      double divisionToday = calculateDivision(occupiedRoomsToday, revenueParToday);
      // Remove non-numeric characters and format double value with NumberFormat
      return NumberFormat('#,##0.00').format(divisionToday);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }
}
