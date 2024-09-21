import 'package:get_storage/get_storage.dart';
import 'package:ipotec/utilities/constants/functions.dart';

final prefs = GetStorage();

setToken(String token) {
  logger.i("TOKEN => $token");
  prefs.write("IS_LOGGED_IN", true);
  prefs.write('TOKEN', token);
}

setFCMToken(String token) {
  logger.i("FCM TOKEN => $token");
  prefs.write('FCM_TOKEN', token);
}

String? getFCMToken() {
  return prefs.read("FCM_TOKEN");
}

clearToken() {
  prefs.remove("IS_LOGGED_IN");
  prefs.remove('TOKEN');
}

isLoggedIn() {
  final loggedIn = prefs.read("IS_LOGGED_IN");

  if (loggedIn == null || loggedIn == false) {
    return false;
  }
  return true;
}

clearPrefs() async {
  await prefs.erase();
}
