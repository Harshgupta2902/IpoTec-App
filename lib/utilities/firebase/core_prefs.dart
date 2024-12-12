import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final prefs = GetStorage();

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
  prefs.write('FCM_TOKEN', token);
}

String? getFCMToken() {
  return prefs.read("FCM_TOKEN");
}

isLoggedIn() {
  final loggedIn = prefs.read("IS_LOGGED_IN");
  final uuid = prefs.read("uuid");

  if (loggedIn == null || loggedIn == false) {
    return false;
  }
  return loggedIn == true && uuid != null ? true : false;
}

setStaticPref() {
  prefs.write("IS_LOGGED_IN", true);
  prefs.write("uuid", "103613902297637442609");
}

clearPrefs() async {
  await prefs.erase();
}
