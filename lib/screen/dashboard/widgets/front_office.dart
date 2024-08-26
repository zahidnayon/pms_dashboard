import 'package:flutter/material.dart';

class FrontOffice extends StatelessWidget {
  const FrontOffice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}








// import 'package:flutter/material.dart';
// import 'package:pms_dashboard/widgets/arr_item.dart';
// import 'package:pms_dashboard/widgets/hot_rev_par_item.dart';
// import 'package:pms_dashboard/widgets/occupied_rooms_item.dart';
// import 'package:pms_dashboard/widgets/of_occupancy_item.dart';
// import 'package:pms_dashboard/widgets/reservation_item.dart';
// import 'package:pms_dashboard/widgets/rev_par_item.dart';
// import 'package:pms_dashboard/widgets/revenue_item.dart';
// import 'package:pms_dashboard/widgets/rooms_available_item.dart';
// import 'package:pms_dashboard/widgets/total_room.dart';
//
// class FrontOffice extends StatelessWidget {
//     final DateTime? fromDate;
//   final DateTime? toDate;
//
//   FrontOffice({this.fromDate, this.toDate});
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: MediaQuery.of(context).size.width < 600
//             ? 1
//             : MediaQuery.of(context).size.width < 1300
//             ? 2
//             : 3,
//         mainAxisExtent: MediaQuery.of(context).size.height < 600
//             ? 130
//             : 130,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         childAspectRatio: 1.0,
//       ),
//       itemCount: 8, // Number of items in the grid
//       itemBuilder: (context, index) {
//         // Return the corresponding widget for each item
//         switch (index) {
//           case 0:
//             return RevenueItem(fromDate: fromDate, toDate: toDate);
//           case 1:
//             return ArrItem();
//           case 2:
//             return RevParItem();
//           case 3:
//             return HotRevParItem();
//           case 4:
//             return ReservationItem();
//           case 5:
//             return RoomsAvailableItem();
//           case 6:
//             return OccupiedRoomsItem();
//           case 7:
//             return OfOccupancyItem();
//           case 8:
//             return TotalRoomsItem();
//           default:
//             return Container();
//         }
//       },
//     );
//   }
// }
