import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pms_dashboard/conostants.dart';

class RevenuePar extends StatefulWidget {
  @override
  _RevenueParState createState() => _RevenueParState();
}

class _RevenueParState extends State<RevenuePar> {
  String revenueParYTD = '';
  String revenueParMTD = '';
  String revenueParToday = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final Uri url = Uri.parse('http://109.123.239.245:800/FlexAPI/api/WebDashboard/GetChartDashboardDetails?clm02=25-Jan-24&clm05=MOV&clm24=0106');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        revenueParYTD = data['clM09'].toString();
        revenueParMTD = data['clM12'].toString();
        revenueParToday = data['clM06'].toString();
      });
    } else {
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$revenueParYTD:YTD",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$revenueParMTD:MTD",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$revenueParToday:Today",
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
