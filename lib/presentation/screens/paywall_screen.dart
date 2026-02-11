import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/subscription_repository.dart';
import '../../logic/subscription_cubit.dart';
import '../../logic/subscription_state.dart';
import '../widgets/primary_button.dart';
import '../widgets/subscription_option_card.dart';
import 'main_screen.dart';

class PaywallScreen extends StatefulWidget {
  static const routeName = '/paywall';

  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.yearly;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Откройте полный доступ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Без ограничений, без рекламы и с новыми функциями раньше всех.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '7 дней бесплатного периода можно просто представить :)',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SubscriptionOptionCard(
                title: 'Месяц',
                price: '399 ₽ в месяц',
                isSelected: _selectedPlan == SubscriptionPlan.monthly,
                onTap: () {
                  setState(() {
                    _selectedPlan = SubscriptionPlan.monthly;
                  });
                },
              ),
              const SizedBox(height: 12),
              SubscriptionOptionCard(
                title: 'Год',
                price: '199 ₽ в месяц, списание раз в год',
                badge: '-40 %',
                isSelected: _selectedPlan == SubscriptionPlan.yearly,
                onTap: () {
                  setState(() {
                    _selectedPlan = SubscriptionPlan.yearly;
                  });
                },
              ),
              const Spacer(),
              BlocConsumer<SubscriptionCubit, SubscriptionState>(
                listener: (context, state) {
                  if (!state.isProcessing &&
                      state.plan != SubscriptionPlan.none) {
                    Navigator.of(context).pushReplacementNamed(
                      MainScreen.routeName,
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    label: 'Продолжить',
                    isLoading: state.isProcessing,
                    onPressed: () {
                      context.read<SubscriptionCubit>().purchase(_selectedPlan);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(MainScreen.routeName);
                  },
                  child: const Text('Продолжить без подписки'),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
