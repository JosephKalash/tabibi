import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';

class Logout extends Usecase{
  
  void call(User user) {
    user.token = '';
    user.userId = '';
    user.expiryTime = null;
  }
}
