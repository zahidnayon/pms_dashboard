// class ReservationData {
//   final String particulars;
//   final String total;
//   final Map<String, String> dailyValues;
//
//   ReservationData({
//     required this.particulars,
//     required this.total,
//     required this.dailyValues,
//   });
//
//   factory ReservationData.fromJson(Map<String, dynamic> json) {
//     final dailyValues = Map<String, String>.from(json)
//       ..remove('RMTID')
//       ..remove('PARTICULARS')
//       ..remove('TOTAL');
//
//     return ReservationData(
//       particulars: json['PARTICULARS'] as String,
//       total: json['TOTAL'] as String,
//       dailyValues: dailyValues,
//     );
//   }
// }
