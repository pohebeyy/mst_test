import '../data/subscription_repository.dart';

class SubscriptionState {
  final SubscriptionPlan plan;
  final bool isProcessing;

  const SubscriptionState({
    required this.plan,
    this.isProcessing = false,
  });

  SubscriptionState copyWith({
    SubscriptionPlan? plan,
    bool? isProcessing,
  }) {
    return SubscriptionState(
      plan: plan ?? this.plan,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
