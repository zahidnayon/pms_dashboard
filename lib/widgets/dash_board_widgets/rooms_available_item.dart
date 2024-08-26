import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pms_dashboard/conostants.dart';

class RoomsAvailableItem extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  RoomsAvailableItem({this.fromDate, this.toDate});

  @override
  _RoomsAvailableItemState createState() => _RoomsAvailableItemState();
}

class _RoomsAvailableItemState extends State<RoomsAvailableItem> {
  String totalRoomsYTD = '';
  String totalRoomsMTD = '';
  String totalRoomsToday = '';

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
  void didUpdateWidget(covariant RoomsAvailableItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fromDate != widget.fromDate || oldWidget.toDate != widget.toDate) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      noDataMessage = '';
    });

    final String urlTotalRooms;
    final String urlOccupiedRooms;

    if (widget.fromDate == null || widget.toDate == null) {
      // Fetch all-time data if no date range is selected
      urlTotalRooms = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0134';
      urlOccupiedRooms = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0101';
    } else {
      // Fetch data for the selected date range
      final String formattedFromDate = DateFormat('dd-MMM-yy').format(widget.fromDate!);
      final String formattedToDate = DateFormat('dd-MMM-yy').format(widget.toDate!);

      urlTotalRooms = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0134&clm03=$formattedToDate';
      urlOccupiedRooms = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0101&clm03=$formattedToDate';
    }

    try {
      final totalRoomsResponse = await http.get(Uri.parse(urlTotalRooms));
      final occupiedRoomsResponse = await http.get(Uri.parse(urlOccupiedRooms));

      if (totalRoomsResponse.statusCode == 200 && occupiedRoomsResponse.statusCode == 200) {
        final totalRoomsData = json.decode(totalRoomsResponse.body);
        final occupiedRoomsData = json.decode(occupiedRoomsResponse.body);

        setState(() {
          if (totalRoomsData.isEmpty || occupiedRoomsData.isEmpty) {
            noDataMessage = 'No data available for the selected date range.';
          } else {
            totalRoomsYTD = totalRoomsData['clM09'].toString();
            totalRoomsMTD = totalRoomsData['clM12'].toString();
            totalRoomsToday = totalRoomsData['clM06'].toString();

            occupiedRoomsYTD = occupiedRoomsData['clM09'].toString();
            occupiedRoomsMTD = occupiedRoomsData['clM12'].toString();
            occupiedRoomsToday = occupiedRoomsData['clM06'].toString();
          }
          isLoading = false;
        });
      } else {
        setState(() {
          noDataMessage = 'Failed to load data.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        noDataMessage = 'Failed to load data: $e';
        isLoading = false;
      });
    }
  }

  int calculateDifference(String totalRooms, String occupiedRooms) {
    int totalRoomsInt = int.tryParse(totalRooms) ?? 0;
    int occupiedRoomsInt = int.tryParse(occupiedRooms) ?? 0;
    return totalRoomsInt - occupiedRoomsInt;
  }

  @override
  Widget build(BuildContext context) {
    int differenceYTD = calculateDifference(totalRoomsYTD, occupiedRoomsYTD);
    int differenceMTD = calculateDifference(totalRoomsMTD, occupiedRoomsMTD);
    int differenceToday = calculateDifference(totalRoomsToday, occupiedRoomsToday);

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
                    "ROOM AVAILABLE",
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
                      isLoading
                          ? CircularProgressIndicator() // Show indicator while loading
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            parseDifference(differenceYTD),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            parseDifference(differenceMTD),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            parseDifference(differenceToday),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
                          SizedBox(height: 6),
                          Text(
                            "  :  ",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "  :  ",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
                          SizedBox(height: 6),
                          Text(
                            "MTD",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Today",
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
                ],
              ),
            ],
          ),
        ),
        if (noDataMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              noDataMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  String parseDifference(int difference) {
    try {
      return NumberFormat('#,##0').format(difference);
    } catch (e) {
      return 'Invalid data';
    }
  }
}
