import 'package:tabibi/features/authentication/domain/entities/user.dart';

class Logout {
  
  void call(User user) {
    user.token = '';
    user.userId = '';
    user.expiryTime = null;
  }
}
