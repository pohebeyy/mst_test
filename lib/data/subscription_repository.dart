import 'package:shared_preferences/shared_preferences.dart';

enum SubscriptionPlan {
  none,
  monthly,
  yearly,
}

class SubscriptionRepository {
  static const _keyPlan = 'subscription_plan';
  static const _keyOnboarding = 'onboarding_completed';

  final SharedPreferences prefs;

  SubscriptionRepository(this.prefs);

  SubscriptionPlan getCurrentPlan() {
    final value = prefs.getString(_keyPlan) ?? 'none';
    switch (value) {
      case 'monthly':
        return SubscriptionPlan.monthly;
      case 'yearly':
        return SubscriptionPlan.yearly;
      default:
        return SubscriptionPlan.none;
    }
  }

  Future<void> savePlan(SubscriptionPlan plan) async {
    String value = 'none';
    switch (plan) {
      case SubscriptionPlan.monthly:
        value = 'monthly';
        break;
      case SubscriptionPlan.yearly:
        value = 'yearly';
        break;
      case SubscriptionPlan.none:
        value = 'none';
        break;
    }
    await prefs.setString(_keyPlan, value);
  }

  bool get hasActiveSubscription => getCurrentPlan() != SubscriptionPlan.none;

  bool get onboardingCompleted => prefs.getBool(_keyOnboarding) ?? false;

  Future<void> setOnboardingCompleted() async {
    await prefs.setBool(_keyOnboarding, true);
  }
}
