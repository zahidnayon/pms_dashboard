// import 'package:flutter/material.dart';
// import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pms_dashboard/conostants.dart';
// import 'package:pms_dashboard/screen/dashboard/widgets/bar_chart.dart';
// import 'package:pms_dashboard/screen/first_container.dart';
// import 'dashboard/widgets/daily_occupancy_overview.dart';
// import 'drawer/left_drawer.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
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
//       ),
//       drawer: LeftDrawer(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//           child: Column(
//             children: [
//             FirstContainer(),
//               SizedBox(height: defaultPadding * 2),
//               ChartSurvey(),
//               SizedBox(height: defaultPadding * 2),
//               Container(
//                 padding: EdgeInsets.all(defaultPadding),
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: primaryColor,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Guest",
//                       style: GoogleFonts.ubuntu(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 8,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "Guests",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "Adults",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "Children",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "12879",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "9594",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "3285",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: defaultPadding * 2,),
//                     Padding(padding: EdgeInsets.only(bottom: 5),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Bangladesh",
//                                 style: GoogleFonts.ubuntu(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               RichText(
//                                 text:TextSpan(
//                                   text: "8865",
//                                   style: GoogleFonts.ubuntu(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: "  Guests",
//                                       style: GoogleFonts.ubuntu(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     )
//                                   ]
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                     ),
//                     SizedBox(height: 9,
//                     width: double.infinity,
//                       child: GFProgressBar(
//                       margin:EdgeInsets.only(left:0),
//                         percentage: 0.9,
//                         backgroundColor: bgColor,
//                         linearGradient: LinearGradient(
//                           colors: [
//                             Color(0xFF5747EF),
//                             Color(0xFF58D9D9),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 12,),
//                     Padding(padding: EdgeInsets.only(bottom: 5),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Bhutan",
//                                 style: GoogleFonts.ubuntu(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               RichText(
//                                 text:TextSpan(
//                                     text: "4327",
//                                     style: GoogleFonts.ubuntu(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                         text: "  Guests",
//                                         style: GoogleFonts.ubuntu(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       )
//                                     ]
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                     ),
//                     SizedBox(height: 7,
//                       width: double.infinity,
//                       child: GFProgressBar(
//                         margin:EdgeInsets.only(left:0),
//                         percentage: 0.4,
//                         backgroundColor: bgColor,
//                         linearGradient: LinearGradient(
//                           colors: [
//                             Color(0xFF5747EF),
//                             Color(0xFF58D9D9),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 12,),
//                     Padding(padding: EdgeInsets.only(bottom: 5),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Nepal",
//                                 style: GoogleFonts.ubuntu(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               RichText(
//                                 text:TextSpan(
//                                     text: "5987",
//                                     style: GoogleFonts.ubuntu(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                         text: "  Guests",
//                                         style: GoogleFonts.ubuntu(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       )
//                                     ]
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                     ),
//                     SizedBox(height: 2,
//                       width: double.infinity,
//                       child: GFProgressBar(
//                         margin:EdgeInsets.only(left:0),
//                         percentage: 0.7,
//                         backgroundColor: bgColor,
//                         linearGradient: LinearGradient(
//                           colors: [
//                             Color(0xFF5747EF),
//                             Color(0xFF58D9D9),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 12,),
//                     Padding(padding: EdgeInsets.only(bottom: 5),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "India",
//                                 style: GoogleFonts.ubuntu(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               RichText(
//                                 text:TextSpan(
//                                     text: "6578",
//                                     style: GoogleFonts.ubuntu(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                         text: "  Guests",
//                                         style: GoogleFonts.ubuntu(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       )
//                                     ]
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                     ),
//                     SizedBox(height: 7,
//                       width: double.infinity,
//                       child: GFProgressBar(
//                         margin:EdgeInsets.only(left:0),
//                         percentage: 0.8,
//                         backgroundColor: bgColor,
//                         linearGradient: LinearGradient(
//                           colors: [
//                             Color(0xFF5747EF),
//                             Color(0xFF58D9D9),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: defaultPadding * 2),
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: primaryColor,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),// Adjust the height of the container as needed
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       BarChart(
//                         data: [
//                           BarChartData(month: 'Jan', amount: 6548),
//                           BarChartData(month: 'Feb', amount: 9732),
//                           BarChartData(month: 'Mar', amount: 4579),
//                           BarChartData(month: 'Apr', amount: 8476),
//                           BarChartData(month: 'May', amount: 6346),
//                           BarChartData(month: 'Jun', amount: 2785),
//                           BarChartData(month: 'jul', amount: 6234),
//                           BarChartData(month: 'Aug', amount: 8673),
//                           BarChartData(month: 'Sep', amount: 4985),
//                           BarChartData(month: 'Oct', amount: 7645),
//                           BarChartData(month: 'Nov', amount: 3459),
//                           BarChartData(month: 'Dec', amount: 5656),
//                           // Add more data as needed
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
