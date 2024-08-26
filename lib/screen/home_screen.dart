import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pms_dashboard/screen/dashboard/dash_board.dart';
import 'package:pms_dashboard/screen/dashboard/widgets/bottom_floating_action_button.dart';
import 'package:pms_dashboard/screen/dashboard/widgets/bottom_nav_bar.dart';
import 'package:pms_dashboard/screen/drawer/left_drawer.dart';
import 'package:pms_dashboard/screen/profile/profile.dart';

import 'quick_view/reservation_forecast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;

  int TabIndex = 0;
  onItemTapped(int index){
    setState(() {
      TabIndex = index;
    });
  }

  final widgetOptions = [
    DashBoard(),
    DashBoard(),
    ReservationForecast(),
    Profile(),

  ];

  void _onDateSelected(DateTime fromDate, DateTime toDate) {
    setState(() {
      _fromDate = fromDate;
      _toDate = toDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PMS",
          style: GoogleFonts.ubuntu(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: LeftDrawer(),
      body: widgetOptions.elementAt(TabIndex),
      bottomNavigationBar: BottomNavBar(context,TabIndex,onItemTapped),
      floatingActionButton: BottomFloatingActionButton(onDateSelected: _onDateSelected),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pms_dashboard/screen/dashboard/dash_board.dart';
// import 'package:pms_dashboard/screen/dashboard/widgets/bottom_nav_bar.dart';
// import 'package:pms_dashboard/screen/dashboard/widgets/front_office.dart';
// import 'package:pms_dashboard/screen/drawer/left_drawer.dart';
// import 'package:pms_dashboard/screen/profile/profile.dart';
//
// import 'quick_view/reservation_forecast.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   DateTime? _fromDate;
//   DateTime? _toDate;
//
//   int TabIndex = 0;
//   onItemTapped(int index){
//     setState(() {
//       TabIndex = index;
//     });
//   }
//
//   final widgetOptions = [
//     FrontOffice(),
//     DashBoard(),
//     ReservationForecast(),
//     Profile(),
//   ];
//
//   void _onDateSelected(DateTime fromDate, DateTime toDate) {
//     setState(() {
//       _fromDate = fromDate;
//       _toDate = toDate;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "PMS Dashboard",
//           style: GoogleFonts.ubuntu(
//             fontSize: 22,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       drawer: LeftDrawer(),
//       body: widgetOptions.elementAt(TabIndex),
//       bottomNavigationBar: BottomNavBar(context, TabIndex, onItemTapped),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _onDateSelected(DateTime.now(), DateTime.now()); // Call _onDateSelected directly
//         },
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }


