import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment-driven configuration.
///
/// Default = the live cloud deployment so the shipped APK works with zero
/// setup; a gitignored `.env` (see `.env.example`) overrides for local dev,
/// e.g. `API_BASE_URL=http://10.0.2.2:8000/api/v1` for the Android emulator.

abstract final class AppConstants {
  static const String defaultBaseUrl =
      'https://fleet-tracking-api.onrender.com/api/v1';

  static String get baseUrl {
    try {
      return dotenv.maybeGet('API_BASE_URL') ?? defaultBaseUrl;
    } on Object {
      // .env not loaded (e.g. unit tests) -> baked-in live URL.
      // (dotenv throws NotInitializedError - an Error, not an Exception.)
      return defaultBaseUrl;
    }
  }

  /// Demo credentials shown as quick-fill chips on the login screen.
  static const String demoDriverEmail = 'ravi@fleet.com';
  static const String demoAdminEmail = 'admin@fleet.com';
  static const String demoPassword = 'password123';

  /// Live-position polling cadence (the simulator publishes every 2s).
  static const Duration livePollInterval = Duration(seconds: 5);
}
