// AuthController tests: session restore + login + logout (mocktail).
import 'package:flutter_test/flutter_test.dart';
import 'package:fleet_tracker/core/errors/app_exception.dart';
import 'package:fleet_tracker/core/models/auth_requests.dart';
import 'package:fleet_tracker/core/models/token_pair.dart';
import 'package:fleet_tracker/core/models/user_profile.dart';
import 'package:fleet_tracker/core/network/api_providers.dart';
import 'package:fleet_tracker/core/network/auth_api.dart';
import 'package:fleet_tracker/core/network/dio_provider.dart';
import 'package:fleet_tracker/core/network/me_api.dart';
import 'package:fleet_tracker/core/providers/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthApi extends Mock implements AuthApi {}

class _MockMeApi extends Mock implements MeApi {}

class _MockTokenStore extends Mock implements TokenStore {}

void main() {
  late _MockAuthApi authApi;
  late _MockMeApi meApi;
  late _MockTokenStore tokenStore;
  late ProviderContainer container;

  final profile = UserProfile(
    id: 2,
    email: 'ravi@fleet.com',
    isAdmin: false,
    createdAt: DateTime.utc(2025, 1, 1),
  );

  setUpAll(() {
    registerFallbackValue(const LoginRequest(email: 'x', password: 'y'));
  });

  setUp(() {
    authApi = _MockAuthApi();
    meApi = _MockMeApi();
    tokenStore = _MockTokenStore();
    container = ProviderContainer(
      overrides: [
        authApiProvider.overrideWithValue(authApi),
        meApiProvider.overrideWithValue(meApi),
        tokenStoreProvider.overrideWithValue(tokenStore),
      ],
    );
    addTearDown(container.dispose);
  });

  group('session restore', () {
    test('no stored token -> signedOut', () async {
      when(() => tokenStore.getAccessToken()).thenAnswer((_) async => null);

      final state = await container.read(authControllerProvider.future);
      expect(state, isA<AuthSignedOut>());
    });

    test('stored token + valid profile -> signedIn', () async {
      when(() => tokenStore.getAccessToken()).thenAnswer((_) async => 'jwt');
      when(() => meApi.getProfile()).thenAnswer((_) async => profile);

      final state = await container.read(authControllerProvider.future);
      final s = state as AuthSignedIn;
      expect(s.profile.email, 'ravi@fleet.com');
    });

    test(
      'stored token but profile call fails -> signedOut (cleared)',
      () async {
        when(() => tokenStore.getAccessToken()).thenAnswer((_) async => 'jwt');
        when(() => tokenStore.clearTokens()).thenAnswer((_) async {});
        when(() => meApi.getProfile())
            .thenThrow(const AppException.unauthorized());

        final state = await container.read(authControllerProvider.future);
        expect(state, isA<AuthSignedOut>());
        verify(() => tokenStore.clearTokens()).called(1);
      },
    );
  });

  group('login', () {
    test('stores tokens, fetches profile, signs in', () async {
      when(() => tokenStore.getAccessToken()).thenAnswer((_) async => null);
      when(() => authApi.login(any(that: isA<LoginRequest>()))).thenAnswer(
        (_) async => const TokenPair(
          accessToken: 'at',
          refreshToken: 'rt',
          tokenType: 'bearer',
          expiresIn: 1800,
        ),
      );
      when(
        () => tokenStore.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      ).thenAnswer((_) async {});
      when(() => meApi.getProfile()).thenAnswer((_) async => profile);

      await container
          .read(authControllerProvider.notifier)
          .login('ravi@fleet.com', 'password123');

      final state = container.read(authControllerProvider).value;
      expect(state, isA<AuthSignedIn>());
      verify(() => tokenStore.saveTokens(accessToken: 'at', refreshToken: 'rt'))
          .called(1);
    });

    test('invalid credentials -> server exception propagates', () async {
      when(() => tokenStore.getAccessToken()).thenAnswer((_) async => null);
      when(() => authApi.login(any(that: isA<LoginRequest>()))).thenThrow(
        const AppException.server(
          statusCode: 401,
          code: 'invalid_credentials',
          message: 'Wrong email or password',
        ),
      );

      await expectLater(
        container
            .read(authControllerProvider.notifier)
            .login('ravi@fleet.com', 'nope12345'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('logout', () {
    test('clears tokens and signs out', () async {
      when(() => tokenStore.getAccessToken()).thenAnswer((_) async => null);
      when(() => tokenStore.clearTokens()).thenAnswer((_) async {});
      // Login first to be signed in.
      when(() => authApi.login(any(that: isA<LoginRequest>()))).thenAnswer(
        (_) async => const TokenPair(accessToken: 'at', refreshToken: 'rt'),
      );
      when(
        () => tokenStore.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      ).thenAnswer((_) async {});
      when(() => meApi.getProfile()).thenAnswer((_) async => profile);

      final notifier = container.read(authControllerProvider.notifier);
      await notifier.login('ravi@fleet.com', 'password123');
      await notifier.logout();

      expect(
        container.read(authControllerProvider).value,
        isA<AuthSignedOut>(),
      );
      verify(() => tokenStore.clearTokens()).called(1);
    });
  });
}
