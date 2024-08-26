import 'package:flutter/material.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/hot_rev_par_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/occupied_rooms_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/of_occupancy_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/reservation_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/rev_par_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/revenue_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/arr_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/rooms_available_item.dart';
import 'package:pms_dashboard/widgets/dash_board_widgets/total_room.dart';

class DashBoard extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  DashBoard({this.fromDate, this.toDate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 600
                ? 1
                : MediaQuery.of(context).size.width < 1300
                ? 2
                : 3,
            mainAxisExtent: MediaQuery.of(context).size.height < 600 ? 130 : 130,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: 9,
          // Change itemCount to 3 for three items
          itemBuilder: (context, index) {
            // Return RevenueItem for index 0, ArrItem for index 1, and HotRevParItem for index 2
            if (index == 0) {
              return RevenueItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 1) {
              return ArrItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 2) {
              return RevParItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 3) {
              return HotRevParItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 4) {
              return ReservationItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 5) {
              return RoomsAvailableItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 6) {
              return OccupiedRoomsItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 7) {
              return OfOccupancyItem(fromDate: fromDate, toDate: toDate);
            } else if (index == 8) {
              return TotalRoomsItem(fromDate: fromDate, toDate: toDate);
            } else {
              // Return a blank container for other indices
              return Container();
            }
          },
        ),
      ),
    );
  }
}