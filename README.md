# Test Subscription App

Flutter-приложение с онбордингом, paywall и главным экраном. Демонстрирует работу с подписками и локальным хранением состояния.

## Архитектура

Приложение следует чистой архитектуре с разделением на три слоя:

- **Data Layer** — `SubscriptionRepository` работает с `SharedPreferences`
- **Logic Layer** — `SubscriptionCubit` (BLoC) управляет бизнес-логикой
- **Presentation Layer** — экраны и переиспользуемые виджеты

## Структура

lib/
├── main.dart
├── app.dart
├── data/
│ └── subscription_repository.dart
├── logic/
│ ├── subscription_cubit.dart
│ └── subscription_state.dart
└── presentation/
├── screens/
│ ├── onboarding_screen.dart
│ ├── paywall_screen.dart
│ └── main_screen.dart
└── widgets/
├── primary_button.dart
└── subscription_option_card.dart


## Установка

```bash
flutter pub get
flutter run
Зависимости
text
dependencies:
  flutter_bloc: ^8.1.3
  shared_preferences: ^2.2.0
Возможные улучшения
Интеграция реального биллинга (in_app_purchase, RevenueCat)

Unit и Widget тесты (покрытие >80%)

Dependency Injection (GetIt)

Firebase Analytics и Crashlytics

Локализация (l10n)

Lottie анимации на онбординге

Темная тема

Адаптивная вёрстка для планшетов
