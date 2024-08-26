import 'package:flutter/material.dart';

BottomAppBar BottomNavBar(BuildContext context, currentIndex, onItemTapped) {
  return BottomAppBar(
    notchMargin: 5,
    shape: CircularNotchedRectangle(),
    color: Colors.black87,
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, size: 22),
              ],
            ),
          ),
          label: 'Home', // Set empty string to hide label
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.dashboard, size: 22),
              ],
            ),
          ),
          label: 'Dashboard', // Set empty string to hide label
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.view_carousel_outlined, size: 22),
              ],
            ),
          ),
          label: 'Quick View', // Set empty string to hide label
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, size: 22),
              ],
            ),
          ),
          label: 'Person', // Set empty string to hide label
        ),
      ], //item
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Colors.transparent,
    ),
  );
}














// import 'package:flutter/material.dart';
// import 'package:pms_dashboard/screen/quick_view/reservation_forecast.dart';
//
// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       child: BottomAppBar(
//         notchMargin: 5,
//         shape: CircularNotchedRectangle(),
//         color: Colors.black87,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 6.0),
//               child: GestureDetector(
//                 onTap: (){},
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.home,size: 22,),
//                     Text("Home", style: TextStyle(color: Colors.white,fontSize: 10),),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 6.0,),
//               child: GestureDetector(
//                 onTap: (){},
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.dashboard,size: 22),
//                     Text("Dashboard", style: TextStyle(color: Colors.white,fontSize: 10)),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(width: 40), // Add space for FAB
//             Padding(
//               padding: const EdgeInsets.only(right: 6.0,),
//               child: GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationForecast()));
//                 },
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.view_carousel_outlined,size: 22),
//                     Text("Quick View", style: TextStyle(color: Colors.white,fontSize: 10)),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 6.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.person,size: 22),
//                     Text("Profile", style: TextStyle(color: Colors.white,fontSize: 10)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


