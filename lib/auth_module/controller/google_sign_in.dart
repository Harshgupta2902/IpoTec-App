import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxBool isLoggingIn = RxBool(false);
  RxBool isSigningIn = RxBool(false);

  googleSignIn(BuildContext context) async {
    debugPrint("LoginController => googleSignIn > start");

    final googleResponse = await _googleSignIn.signIn();

    isLoggingIn.value = true;
    isSigningIn.value = true;

    String? userName = googleResponse?.displayName;
    String? email = googleResponse?.email;
    String? googleID = googleResponse?.id;

    logger.d(userName);
    logger.d(email);
    logger.d(googleID);
    logger.e(googleResponse);
    // await _googleSignIn.signOut();

    if (googleID == null) {
      return;
    }
    isLoggingIn.value = false;
    isSigningIn.value = false;
    debugPrint("LoginController => googleSignIn > success");
  }
}
