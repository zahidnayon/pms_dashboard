import 'package:flutter/material.dart';
import 'package:pms_dashboard/components/date_picker.dart';

class BottomFloatingActionButton extends StatelessWidget {
  final void Function(DateTime fromDate, DateTime toDate) onDateSelected;

  const BottomFloatingActionButton({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: DatePickerWidget(onDateSelected: onDateSelected),
            );
          },
        );
      },
      child: Icon(Icons.calendar_month),
      backgroundColor: Colors.black87,
      foregroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
