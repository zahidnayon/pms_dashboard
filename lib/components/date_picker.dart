import 'package:flutter/material.dart';
import 'package:pms_dashboard/conostants.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime, DateTime) onDateSelected;

  DatePickerWidget({required this.onDateSelected});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now().add(Duration(days: 1));

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
        if (_fromDate.isAfter(_toDate)) {
          _toDate = _fromDate.add(Duration(days: 1));
        }
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate,
      firstDate: _fromDate,
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _toDate) {
      setState(() {
        _toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select Date Range',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text(
                'From Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_fromDate.day}/${_fromDate.month}/${_fromDate.year}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectFromDate(context),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text(
                'To Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_toDate.day}/${_toDate.month}/${_toDate.year}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectToDate(context),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onDateSelected(_fromDate, _toDate);
              Navigator.pop(context, {'fromDate': _fromDate, 'toDate': _toDate});
            },
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
