// Login flow widget test: validation, demo chips, error snackbar
// (mocking the controller, per skill).
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fleet_tracker/core/errors/app_exception.dart';
import 'package:fleet_tracker/core/models/user_profile.dart';
import 'package:fleet_tracker/core/providers/auth_provider.dart';
import 'package:fleet_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:fleet_tracker/generated/l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _MockAuthController extends AuthController {
  _MockAuthController(this.failWith);
  final AppException? failWith;
  int loginCalls = 0;

  @override
  Future<AuthState> build() async => const AuthState.signedOut();

  @override
  Future<void> login(String email, String password) async {
    loginCalls++;
    if (failWith != null) throw failWith!;
    state = AsyncValue.data(AuthState.signedIn(profile: _fakeProfile));
  }
}

final _fakeProfile = UserProfile(
  id: 1,
  email: 'ravi@fleet.com',
  isAdmin: false,
  createdAt: DateTime.utc(2025, 1, 1),
);

Widget _wrap(AuthController controller) => ProviderScope(
  overrides: [authControllerProvider.overrideWith(() => controller)],
  child: ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (_, _) => MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoginScreen(),
    ),
  ),
);

void main() {
  testWidgets('demo chip fills the form', (tester) async {
    await tester.pumpWidget(_wrap(_MockAuthController(null)));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.directions_bus_outlined).last);
    await tester.pump();

    expect(find.text('ravi@fleet.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets('empty submit shows validation messages', (tester) async {
    final controller = _MockAuthController(null);
    await tester.pumpWidget(_wrap(controller));
    await tester.pump();

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('This field is required'), findsOneWidget);
    expect(find.text('At least 8 characters'), findsOneWidget);
    expect(controller.loginCalls, 0);
  });

  testWidgets('invalid credentials shows the localized snackbar', (
    tester,
  ) async {
    final controller = _MockAuthController(
      const AppException.server(
        statusCode: 401,
        code: 'invalid_credentials',
        message: 'Wrong email or password',
      ),
    );
    await tester.pumpWidget(_wrap(controller));
    await tester.pump();

    await tester.enterText(find.byType(TextFormField).at(0), 'ravi@fleet.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Wrong email or password.'), findsOneWidget);
    expect(controller.loginCalls, 1);
  });
}
