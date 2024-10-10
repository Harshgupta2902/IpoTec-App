import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipotec/utilities/common/dialog.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/firebase/notification_service.dart';

class AuthController extends GetxController with StateMixin<UserModel> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rxn<UserModel> currentUser = Rxn<UserModel>(); // Stores logged-in user data

  RxBool isLoggingIn = RxBool(false);

  googleSignIn(BuildContext context) async {
    debugPrint("AuthController => googleSignIn > started");

    try {
      isLoggingIn.value = true;
      coreLoadingDialog(context: context, content: "Signing...");
      // Attempt to sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint("AuthController => googleSignIn > canceled by user");
        isLoggingIn.value = false;
        return;
      }

      debugPrint(
          "AuthController => Google sign-in successful: ${googleUser.displayName}, ${googleUser.email}");

      if (isLoggedIn()) {
        fetchUserData(googleUser.id);
      } else {
        await saveGoogleUserToFirestore(googleUser);
        fetchUserData(googleUser.id);
      }
      coreCloseDialog();
      context.pop();
    } catch (e) {
      debugPrint("AuthController => Error during Google sign-in: $e");
    } finally {
      isLoggingIn.value = false;
      debugPrint("AuthController => googleSignIn > process completed");
    }
  }

  Future<void> saveGoogleUserToFirestore(GoogleSignInAccount googleUser) async {
    try {
      final userRef = _firestore.collection('userData').doc(googleUser.id);

      final fcmToken = CoreNotificationService().getToken();
      await userRef.set({
        'uid': googleUser.id,
        'displayName': googleUser.displayName,
        'email': googleUser.email,
        'photoURL': googleUser.photoUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'token': getFCMToken() ?? fcmToken
      });
      setLogin(true);
      setUuid(googleUser.id);
      debugPrint(
          "AuthController => Google user saved to Firestore: ${googleUser.id}, ${googleUser.email}");
    } catch (e) {
      debugPrint("AuthController => Error saving Google user to Firestore: $e");
    }
  }

  Future<void> googleSignOut(BuildContext context) async {
    debugPrint("AuthController => googleSignOut > started");

    try {
      // Sign out from Google
      await _googleSignIn.signOut();
      setLogin(false);
      currentUser.value = null;
      debugPrint("AuthController => Signed out from Google");
    } catch (e) {
      debugPrint("AuthController => Error during Google sign-out: $e");
    } finally {
      debugPrint("AuthController => googleSignOut > process completed");
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('userData').doc(uid).get();
      if (doc.exists) {
        final modal = UserModel.fromFirestore(doc);
        change(modal, status: RxStatus.success());
        debugPrint("AuthController => User data fetched: ${modal.displayName}");
      } else {
        debugPrint("AuthController => No user data found for uid: $uid");
      }
    } catch (e) {
      debugPrint("AuthController => Error fetching user data: $e");
    }
  }
}

class UserModel {
  String uid;
  String? displayName;
  String? email;
  String? photoURL;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      displayName: data['displayName'],
      email: data['email'],
      photoURL: data['photoURL'],
    );
  }
}
