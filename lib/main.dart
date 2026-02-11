import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/subscription_repository.dart';
import 'logic/subscription_cubit.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/paywall_screen.dart';
import 'presentation/screens/main_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final subscriptionRepository = SubscriptionRepository(prefs);

  final bool hasActiveSubscription = subscriptionRepository.hasActiveSubscription;
  final bool onboardingCompleted = subscriptionRepository.onboardingCompleted;

  final String initialRoute;
  if (hasActiveSubscription) {
    initialRoute = MainScreen.routeName;
  } else if (onboardingCompleted) {
    initialRoute = PaywallScreen.routeName;
  } else {
    initialRoute = OnboardingScreen.routeName;
  }

  runApp(
    MyApp(
      subscriptionRepository: subscriptionRepository,
      initialRoute: initialRoute,
    ),
  );
}
