import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/google_sign_in.dart';
import 'package:ipotec/utilities/common/core_update_handler.dart';
import 'package:ipotec/utilities/constants/functions.dart';

final _authController = Get.put(AuthController());

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uniqueId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        uniqueId = getUniqueId();
      },
    );
    logger.i(uniqueId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(uniqueId ?? "-No Id"),
            ElevatedButton(
              onPressed: () {
                _authController.googleSignIn(context);
              },
              child: const Text("Sing In"),
            ),
          ],
        ),
      ),
    );
  }
}
