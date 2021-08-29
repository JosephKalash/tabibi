import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/usecase/usecase.dart';

class Logout extends Usecase {
  Future<void> call() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
