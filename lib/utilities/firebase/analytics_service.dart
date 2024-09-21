import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  // Create a private static instance of the class
  static final AnalyticsService _instance = AnalyticsService._internal();

  // Make the constructor private so that it can't be called from outside the class
  AnalyticsService._internal();

  // Create a factory constructor that returns the singleton instance
  factory AnalyticsService() => _instance;
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  // Future setUpUserProperties({required String id}) async {
  //   await _firebaseAnalytics.setUserId(id: id);
  // }
}
