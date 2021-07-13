import 'package:tabibi/core/error/failures.dart';

String getErrorMessage(Failure error) {
    if (error is ServerFailure)
      return 'An error occurred on server!';
    else if (error is InternetFailure)
      return 'There is no Internet connection!';
    else if (error is HttpFailure)
      return  error.message;
    else
      return  'Unknown error occurred... try again later';
  }