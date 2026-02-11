import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/subscription_repository.dart';
import 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository repository;

  SubscriptionCubit(this.repository)
      : super(SubscriptionState(plan: repository.getCurrentPlan()));

  Future<void> purchase(SubscriptionPlan plan) async {
    emit(state.copyWith(isProcessing: true));
    // небольшая задержка, чтобы в UI показать загрузку (не обязательно)
    await Future.delayed(const Duration(milliseconds: 500));
    await repository.savePlan(plan);
    emit(state.copyWith(plan: plan, isProcessing: false));
  }
}
