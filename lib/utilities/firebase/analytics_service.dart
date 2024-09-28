import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalyticsService _instance = FirebaseAnalyticsService._internal();

  FirebaseAnalyticsService._internal();

  factory FirebaseAnalyticsService() => _instance;
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  Future setUpUserProperties({required String id}) async {
    await _firebaseAnalytics.setUserId(id: id);
  }

  init(String? id) {
    final analyticsService = FirebaseAnalyticsService();
    FirebaseAnalytics.instance;
    analyticsService.setUpUserProperties(id: id ?? '-');
    FirebaseCrashlytics.instance.setUserIdentifier(id ?? '-');
    FirebaseAnalytics.instance.logEvent(name: 'increment_button_press');
  }
}
