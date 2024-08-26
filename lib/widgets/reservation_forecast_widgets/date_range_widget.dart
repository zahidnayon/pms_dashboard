import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  DateRangeWidget({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DateRangeWidgetState createState() => _DateRangeWidgetState();
}

class _DateRangeWidgetState extends State<DateRangeWidget> {
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  final DateFormat monthFormatter = DateFormat('MMMM');
  final DateFormat dayFormatter = DateFormat('EEEE');
  final DateFormat dateFormatter = DateFormat('MMM d, yyyy');
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> _getFormattedDates(DateTime month) {
    final int daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    List<Map<String, String>> formattedDates = [];
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(month.year, month.month, day);
      formattedDates.add({
        'day': dayFormatter.format(date),
        'date': dateFormatter.format(date),
        'fullDate': date.toIso8601String(),
      });
    }
    return formattedDates;
  }

  List<DropdownMenuItem<DateTime>> _getMonthDropdownItems() {
    List<DropdownMenuItem<DateTime>> items = [];
    for (int month = 1; month <= 12; month++) {
      DateTime date = DateTime(DateTime.now().year, month, 1);
      items.add(DropdownMenuItem(
        value: date,
        child: Text(monthFormatter.format(date)),
      ));
    }
    return items;
  }

  void _scrollToCurrentDate(List<Map<String, String>> formattedDates, double itemWidth) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    int currentIndex = formattedDates.indexWhere((formattedDate) {
      DateTime date = DateTime.parse(formattedDate['fullDate']!);
      return date.isAtSameMomentAs(today);
    });

    if (currentIndex != -1) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          currentIndex * itemWidth,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> formattedDates = _getFormattedDates(selectedDate);
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 3; // Adjust based on desired number of items visible

    if (selectedDate.month == DateTime.now().month && selectedDate.year == DateTime.now().year) {
      _scrollToCurrentDate(formattedDates, itemWidth);
    }

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    return Column(
      children: [
        DropdownButton<DateTime>(
          value: selectedDate,
          items: _getMonthDropdownItems(),
          onChanged: (newDate) {
            setState(() {
              selectedDate = newDate!;
              widget.onDateSelected(selectedDate); // Notify parent widget
            });
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            children: formattedDates.map((formattedDate) {
              DateTime date = DateTime.parse(formattedDate['fullDate']!);
              bool isToday = date.isAtSameMomentAs(today);

              return GestureDetector(
                onTap: () {
                  widget.onDateSelected(date); // Notify parent widget
                },
                child: Container(
                  width: itemWidth - 16, // Adjust for margin and padding
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: isToday ? Colors.greenAccent : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        formattedDate['day']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        formattedDate['date']!,
                        style: TextStyle(
                          fontSize: 13,
                          color: isToday ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
