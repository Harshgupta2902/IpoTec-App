import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseAnalyticsService {
  // Create a private static instance of the class
  static final FirebaseAnalyticsService _instance = FirebaseAnalyticsService._internal();

  // Make the constructor private so that it can't be called from outside the class
  FirebaseAnalyticsService._internal();

  // Create a factory constructor that returns the singleton instance
  factory FirebaseAnalyticsService() => _instance;
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  Future setUpUserProperties({required String id}) async {
    await _firebaseAnalytics.setUserId(id: id);
  }

  init(String? id) {
    final analyticsService = FirebaseAnalyticsService();

    analyticsService.setUpUserProperties(id: id ?? '-');
    FirebaseCrashlytics.instance.setUserIdentifier(id ?? '-');
    FirebaseAnalytics.instance.logEvent(name: 'increment_button_press');
  }
}
