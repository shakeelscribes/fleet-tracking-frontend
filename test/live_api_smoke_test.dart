// End-to-end smoke against the LIVE cloud deployment
// (https://fleet-tracking-api.onrender.com). Run explicitly with:
//   flutter test --tags live
// Excluded from CI (network-dependent); read-only demo-credential flow.
@Tags(['live'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:fleet_tracker/core/models/auth_requests.dart';
import 'package:fleet_tracker/core/models/vehicle_live.dart';
import 'package:fleet_tracker/core/network/auth_api.dart';
import 'package:fleet_tracker/core/network/me_api.dart';
import 'package:fleet_tracker/core/utils/constants.dart';
import 'package:dio/dio.dart';

void main() {
  late Dio dio;
  late AuthApi authApi;
  late MeApi meApi;

  setUpAll(() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        contentType: Headers.jsonContentType,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          // ignore: avoid_print
          print(
            'LIVE-FAIL ${e.requestOptions.method} '
            '${e.requestOptions.uri} -> ${e.response?.statusCode} '
            '${e.response?.data}',
          );
          handler.next(e);
        },
      ),
    );
    authApi = AuthApi(dio);
    meApi = MeApi(dio);
  });

  test(
    'driver demo account: login -> profile -> assignment -> live fix',
    () async {
      final tokens = await authApi.login(
        const LoginRequest(email: 'ravi@fleet.com', password: 'password123'),
      );
      expect(tokens.accessToken, isNotEmpty);

      dio.options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';

      final profile = await meApi.getProfile();
      expect(profile.email, 'ravi@fleet.com');
      expect(profile.isAdmin, isFalse);

      final assignment = await meApi.getAssignment();
      expect(assignment.route, isNotNull);
      expect(assignment.vehicle, isNotNull);

      final polyline = await meApi.getRoute();
      expect(polyline.waypoints.length, greaterThanOrEqualTo(2));

      final live = await meApi.getVehicleCurrent();
      expect(live.vehicleCode, assignment.vehicle!.code);
      // BUS-001 is actively simulated in the cloud; expect coordinates.
      expect(live.lat, isNotNull);
      expect(live.lng, isNotNull);
      expect(liveStatusOf(live.status), LiveStatus.moving);

      final history = await meApi.getVehicleHistory(limit: 10);
      expect(history.points, isNotEmpty);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
