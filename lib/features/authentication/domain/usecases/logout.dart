import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';

class Logout extends Usecase {
  Future<void> call(User user) async {
    user.token = '';
    user.userId = '';
    user.expiryTime = null;
    final preferences = await SharedPreferences.getInstance();

    preferences.clear();
  }
}
