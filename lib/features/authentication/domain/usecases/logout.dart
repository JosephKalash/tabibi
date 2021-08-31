import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/core/utils/constaints.dart';

class Logout extends Usecase {
  Future<void> call() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(kTokenKey);
  }
}
