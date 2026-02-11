import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/subscription_repository.dart';
import '../../logic/subscription_cubit.dart';
import '../../logic/subscription_state.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plan =
        context.select<SubscriptionCubit, SubscriptionPlan>((cubit) => cubit.state.plan);

    String planLabel;
    switch (plan) {
      case SubscriptionPlan.monthly:
        planLabel = 'Месячная подписка';
        break;
      case SubscriptionPlan.yearly:
        planLabel = 'Годовая подписка';
        break;
      case SubscriptionPlan.none:
      default:
        planLabel = 'Без подписки';
        break;
    }

    final features = [
      'Создание заметок и списков дел',
      'Напоминания о важных задачах',
      'Статистика продуктивности',
      'Синхронизация между устройствами (воображаемая)',
      'Приоритетная поддержка (для подписки)',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                planLabel,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView.separated(
            itemCount: features.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        features[index],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
