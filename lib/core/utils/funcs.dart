import 'package:intl/intl.dart';
import 'package:tabibi/core/error/failures.dart';

String getErrorMessage(Failure error) {
    if (error is ServerFailure)
      return 'خطأ بالاتصال بالمخدم!';
    else if (error is InternetFailure)
      return 'لا يوجد اتصال بالشبكة!';
    else if (error is HttpFailure)
      return  error.message;
    else
      return  'Unknown error occurred... try again later';
  }

  String getArabicDate(DateTime dateTime) {
  final day = dateTime.weekday;
  final date = DateFormat('M/d').format(dateTime);
  String dayName;
  switch (day) {
    case 1:
      dayName = 'الأثنين';
      break;
    case 2:
      dayName = 'الثلاثاء';
      break;
    case 3:
      dayName = 'الأربعاء';
      break;
    case 4:
      dayName = 'الخميس';
      break;
    case 5:
      dayName = 'الجمعة';
      break;
    case 6:
      dayName = 'السبت';
      break;
    case 7:
      dayName = 'الأحد';
      break;
    default:
      dayName = '';
      break;
  }
  return '$dayName  $date';
}
