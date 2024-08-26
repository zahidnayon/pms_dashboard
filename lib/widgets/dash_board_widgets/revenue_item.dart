import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pms_dashboard/conostants.dart';

class RevenueItem extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  RevenueItem({this.fromDate, this.toDate});

  @override
  _RevenueItemState createState() => _RevenueItemState();
}

class _RevenueItemState extends State<RevenueItem> {
  String revenueYTD = '';
  String revenueMTD = '';
  String revenueToday = '';
  bool isLoading = true;
  String noDataMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant RevenueItem oldWidget) {
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
          'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0161';
    } else {
      // Fetch data for the selected date range
      url =
          'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0161&clm03=$formattedToDate';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response data: $data');
      setState(() {
        if (data.isEmpty) {
          noDataMessage = 'No data available for the selected date range.';
        } else {
          revenueYTD = data['clM09'].toString();
          revenueMTD = data['clM12'].toString();
          revenueToday = data['clM06'].toString();
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
                    "REVENUE",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    "assets/icons/revenue.png",
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
                                  parseRevenueYTD(),
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  parseRevenueMTD(),
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  parseRevenueToday(),
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
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "  :  ",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 6,
                          ),
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
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "MTD",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
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

  String parseRevenueYTD() {
    try {
      // Remove non-numeric characters and parse double
      final doubleValue =
          double.parse(revenueYTD.replaceAll(RegExp(r'[^0-9.]'), ''));
      // Format double value with NumberFormat
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

  String parseRevenueMTD() {
    try {
      // Remove non-numeric characters and parse double
      final doubleValue =
          double.parse(revenueMTD.replaceAll(RegExp(r'[^0-9.]'), ''));
      // Format double value with NumberFormat
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }

  String parseRevenueToday() {
    try {
      // Remove non-numeric characters and parse double
      final doubleValue =
          double.parse(revenueToday.replaceAll(RegExp(r'[^0-9.]'), ''));
      // Format double value with NumberFormat
      return NumberFormat('#,##0.00').format(doubleValue);
    } catch (e) {
      // Return error message if parsing fails
      return 'Invalid data';
    }
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:pms_dashboard/conostants.dart';
//
// class RevenueItem extends StatefulWidget {
//   final DateTime? fromDate;
//   final DateTime? toDate;
//
//   RevenueItem({this.fromDate, this.toDate});
//
//   @override
//   _RevenueItemState createState() => _RevenueItemState();
// }
//
// class _RevenueItemState extends State<RevenueItem> {
//   String revenueYTD = '';
//   String revenueMTD = '';
//   String revenueToday = '';
//   bool isLoading = true;
//   String noDataMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   @override
//   void didUpdateWidget(covariant RevenueItem oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.fromDate != widget.fromDate || oldWidget.toDate != widget.toDate) {
//       fetchData();
//     }
//   }
//
//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//       noDataMessage = '';
//     });
//
//     final DateTime fromDate = widget.fromDate ?? DateTime.now();
//     final DateTime toDate = widget.toDate ?? DateTime.now();
//     final String formattedFromDate = DateFormat('dd-MMM-yy').format(fromDate);
//     final String formattedToDate = DateFormat('dd-MMM-yy').format(toDate);
//
//     final String url;
//     if (widget.fromDate == null || widget.toDate == null) {
//       // Fetch all-time data if no date range is selected
//       url = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm05=MOV&clm24=0161';
//     } else {
//       // Fetch data for the selected date range
//       url = 'http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=$formattedFromDate&clm05=MOV&clm24=0161&clm03=$formattedToDate';
//     }
//
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print('API response data: $data');
//       setState(() {
//         if (data.isEmpty) {
//           noDataMessage = 'No data available for the selected date range.';
//         } else {
//           revenueYTD = data['clM09'].toString();
//           revenueMTD = data['clM12'].toString();
//           revenueToday = data['clM06'].toString();
//         }
//         isLoading = false;
//       });
//     } else if (response.statusCode == 204) {
//       setState(() {
//         noDataMessage = 'No data available.';
//         isLoading = false;
//       });
//     } else {
//       print('Failed to load data with status code: ${response.statusCode}');
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "REVENUE",
//                     style: GoogleFonts.ubuntu(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Image.asset(
//                     "assets/icons/revenue.png",
//                     height: 50,
//                     width: 50,
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   isLoading
//                       ? CircularProgressIndicator()
//                       : noDataMessage.isNotEmpty
//                       ? Text(
//                     noDataMessage,
//                     style: GoogleFonts.ubuntu(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   )
//                       : Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             parseRevenueYTD(),
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             parseRevenueMTD(),
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             parseRevenueToday(),
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "  :  ",
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             "  :  ",
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             "  :  ",
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "YTD",
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             "MTD",
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             "Today",
//                             style: GoogleFonts.ubuntu(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   String parseRevenueYTD() {
//     try {
//       final doubleValue = double.parse(revenueYTD.replaceAll(RegExp(r'[^0-9.]'), ''));
//       return NumberFormat('#,##0.00').format(doubleValue);
//     } catch (e) {
//       return 'Invalid data';
//     }
//   }
//
//   String parseRevenueMTD() {
//     try {
//       final doubleValue = double.parse(revenueMTD.replaceAll(RegExp(r'[^0-9.]'), ''));
//       return NumberFormat('#,##0.00').format(doubleValue);
//     } catch (e) {
//       return 'Invalid data';
//     }
//   }
//
//   String parseRevenueToday() {
//     try {
//       final doubleValue = double.parse(revenueToday.replaceAll(RegExp(r'[^0-9.]'), ''));
//       return NumberFormat('#,##0.00').format(doubleValue);
//     } catch (e) {
//       return 'Invalid data';
//     }
//   }
// }
