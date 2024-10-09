import 'package:get_storage/get_storage.dart';
import 'package:ipotec/utilities/constants/functions.dart';

final prefs = GetStorage();

setToken(String token) {
  logger.i("TOKEN => $token");
  // prefs.write("IS_LOGGED_IN", true);
  prefs.write('TOKEN', token);
}

setLogin(bool login) {
  prefs.write("IS_LOGGED_IN", login);
}

setUuid(String uuid) {
  prefs.write("uuid", uuid);
}

getUuid() {
  return prefs.read("uuid");
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
  final uuid = prefs.read("uuid");

  if (loggedIn == null || loggedIn == false) {
    return false;
  }
  return loggedIn == true && uuid != null ? true : false;
}

clearPrefs() async {
  await prefs.erase();
}
