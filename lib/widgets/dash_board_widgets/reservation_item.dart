import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pms_dashboard/conostants.dart';

class ReservationItem extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  ReservationItem({this.fromDate, this.toDate});

  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  String reservationYTD = '';
  String reservationMTD = '';
  String reservationToday = '';
  bool isLoading = true;
  String noDataMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant ReservationItem oldWidget) {
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

    final String url;

    if (widget.fromDate == null || widget.toDate == null) {
      // Fetch all-time data if no date range is selected
      url = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetReservationData?toDate=01-jun-23&fromDate=30-jun-24';
    } else {
      // Fetch data for the selected date range
      final String formattedFromDate = DateFormat('yyyy-MM-dd').format(widget.fromDate!);
      final String formattedToDate = DateFormat('yyyy-MM-dd').format(widget.toDate!);

      url = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetReservationData?toDate=$formattedToDate&fromDate=$formattedFromDate';
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          if (data.isEmpty) {
            noDataMessage = 'No data available for the selected date range.';
          } else {
            reservationYTD = data['clM11'].toString();
            reservationMTD = data['clM11'].toString();
            reservationToday = data['clM11'].toString();
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
                    "RESERVATION",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    "assets/icons/reservation.png",
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
                          ? CircularProgressIndicator()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            parseReservation(reservationYTD),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            parseReservation(reservationMTD),
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            parseReservation(reservationToday),
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

  String parseReservation(String reservation) {
    try {
      final doubleValue = double.parse(reservation.replaceAll(RegExp(r'[^0-9.]'), ''));
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      return 'Invalid data';
    }
  }
}
