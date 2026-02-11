import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/subscription_repository.dart';
import 'logic/subscription_cubit.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/paywall_screen.dart';
import 'presentation/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  final SubscriptionRepository subscriptionRepository;
  final String initialRoute;

  const MyApp({
    super.key,
    required this.subscriptionRepository,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: subscriptionRepository,
      child: BlocProvider(
        create: (_) => SubscriptionCubit(subscriptionRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test Subscription App',
          theme: ThemeData(
            primaryColor: const Color(0xFF4A6FFF),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4A6FFF),
            ),
            scaffoldBackgroundColor: const Color(0xFFF5F6FA),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              bodyMedium: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          initialRoute: initialRoute,
          routes: {
            OnboardingScreen.routeName: (_) => const OnboardingScreen(),
            PaywallScreen.routeName: (_) => const PaywallScreen(),
            MainScreen.routeName: (_) => const MainScreen(),
          },
        ),
      ),
    );
  }
}
