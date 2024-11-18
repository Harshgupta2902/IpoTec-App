import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipotec/auth_module/view/login_view.dart';
import 'package:ipotec/utilities/common/scaffold_messenger.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

class AuthController extends GetxController with StateMixin<UserModel> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rxn<UserModel> currentUser = Rxn<UserModel>(); // Stores logged-in user data

  RxBool isLoggingIn = RxBool(false);

  googleSignIn({bool? isPop = false, required CallApiType type}) async {
    debugPrint("AuthController => googleSignIn > started");

    try {
      isLoggingIn.value = true;
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

      if (isPop == true) {
        MyNavigator.pop();
      }

      if (type == CallApiType.gmp) {
        MyNavigator.pushNamed(GoPaths.gmp);
      } else if (type == CallApiType.subs) {
        MyNavigator.pushNamed(GoPaths.subs);
      } else {
        MyNavigator.pushNamed(GoPaths.mainBoard);
      }

      messageScaffold(
        content: "Login Successful ${googleUser.displayName}",
        messageScaffoldType: MessageScaffoldType.success,
      );
    } catch (e) {
      debugPrint("AuthController => Error during Google sign-in: $e");
      messageScaffold(
        content: "Something Went Wrong!",
        messageScaffoldType: MessageScaffoldType.error,
      );
    } finally {
      isLoggingIn.value = false;
      debugPrint("AuthController => googleSignIn > process completed");
    }
  }

  Future<void> saveGoogleUserToFirestore(GoogleSignInAccount googleUser) async {
    try {
      final userRef = _firestore.collection('userData').doc(googleUser.id);

      await userRef.set({
        'uid': googleUser.id,
        'displayName': googleUser.displayName,
        'email': googleUser.email,
        'photoURL': googleUser.photoUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'token': getFCMToken()
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
      messageScaffold(
        content: "Logout Successful",
        messageScaffoldType: MessageScaffoldType.success,
      );
    } catch (e) {
      debugPrint("AuthController => Error during Google sign-out: $e");
      messageScaffold(
        content: "Something Went Wrong!",
        messageScaffoldType: MessageScaffoldType.error,
      );
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
        setLogin(true);
        setUuid(modal.uid);

        String currentToken = getFCMToken() ?? "";
        if (modal.token != currentToken) {
          await _updateUserToken(uid, currentToken);
        }
      } else {
        debugPrint("AuthController => No user data found for uid: $uid");
      }
    } catch (e) {
      debugPrint("AuthController => Error fetching user data: $e");
    }
  }

  Future<void> _updateUserToken(String uid, String newToken) async {
    try {
      final userRef = _firestore.collection('userData').doc(uid);
      await userRef.update({'token': newToken, 'updatedAt': FieldValue.serverTimestamp()});

      debugPrint("AuthController => Updated user token for uid: $uid");
    } catch (e) {
      debugPrint("AuthController => Error updating token for uid: $uid: $e");
    }
  }
}

class UserModel {
  String uid;
  String? displayName;
  String? email;
  String? photoURL;
  String? token;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
    this.token,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      displayName: data['displayName'],
      email: data['email'],
      photoURL: data['photoURL'],
      token: data['token'],
    );
  }
}
