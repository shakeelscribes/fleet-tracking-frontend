// Model JSON round-trips against REAL backend payloads (contract tests).
import 'package:flutter_test/flutter_test.dart';
import 'package:fleet_tracker/core/models/admin_vehicle.dart';
import 'package:fleet_tracker/core/models/assignment.dart';
import 'package:fleet_tracker/core/models/history.dart';
import 'package:fleet_tracker/core/models/route_polyline.dart';
import 'package:fleet_tracker/core/models/token_pair.dart';
import 'package:fleet_tracker/core/models/user_profile.dart';
import 'package:fleet_tracker/core/models/vehicle_live.dart';

void main() {
  group('TokenPair', () {
    test('parses snake_case login response', () {
      final t = TokenPair.fromJson(const {
        'access_token': 'a.b.c',
        'refresh_token': 'r.s.t',
        'token_type': 'bearer',
        'expires_in': 1800,
      });
      expect(t.accessToken, 'a.b.c');
      expect(t.refreshToken, 'r.s.t');
      expect(t.expiresIn, 1800);
    });
  });

  group('UserProfile', () {
    test('parses /me/profile (role + ids)', () {
      final p = UserProfile.fromJson(const {
        'id': 2,
        'email': 'ravi@fleet.com',
        'is_admin': false,
        'route_id': 1,
        'vehicle_id': 1,
        'created_at': '2025-01-01T00:00:00Z',
      });
      expect(p.isAdmin, isFalse);
      expect(p.routeId, 1);
      expect(p.vehicleId, 1);
    });
  });

  group('Assignment', () {
    test('parses the strictly-own pair', () {
      final a = Assignment.fromJson(const {
        'route': {'id': 1, 'name': 'City Center to Airport'},
        'vehicle': {'id': 1, 'code': 'BUS-001', 'name': 'Bluebird'},
      });
      expect(a.route?.name, 'City Center to Airport');
      expect(a.vehicle?.code, 'BUS-001');
    });

    test('parses the unassigned shape', () {
      final a = Assignment.fromJson(const {'route': null, 'vehicle': null});
      expect(a.route, isNull);
      expect(a.vehicle, isNull);
    });
  });

  group('RoutePolyline', () {
    test('parses waypoints (lat/lng)', () {
      final r = RoutePolyline.fromJson(const {
        'id': 1,
        'name': 'City Center to Airport',
        'waypoints': [
          {'lat': 12.9716, 'lng': 77.5946},
          {'lat': 12.98, 'lng': 77.60},
        ],
      });
      expect(r.waypoints, hasLength(2));
      expect(r.waypoints.first.lat, 12.9716);
    });
  });

  group('VehicleLive', () {
    test('parses a live fix', () {
      final v = VehicleLive.fromJson(const {
        'vehicle_id': 1,
        'vehicle_code': 'BUS-001',
        'lat': 12.97,
        'lng': 77.59,
        'speed': 41.5,
        'recorded_at': '2025-01-01T10:00:00Z',
        'status': 'moving',
      });
      expect(liveStatusOf(v.status), LiveStatus.moving);
      expect(v.speed, 41.5);
    });

    test('offline before the first fix', () {
      final v = VehicleLive.fromJson(const {
        'vehicle_id': 1,
        'vehicle_code': 'BUS-001',
        'lat': null,
        'lng': null,
        'speed': null,
        'recorded_at': null,
        'status': 'offline',
      });
      expect(v.lat, isNull);
      expect(liveStatusOf(v.status), LiveStatus.offline);
    });
  });

  group('HistoryOut', () {
    test('parses the points array', () {
      final h = HistoryOut.fromJson(const {
        'vehicle_id': 1,
        'count': 1,
        'points': [
          {
            'lat': 12.97,
            'lng': 77.59,
            'speed': 30.0,
            'recorded_at': '2025-01-01T10:00:00Z',
          },
        ],
      });
      expect(h.count, 1);
      expect(h.points.single.speed, 30.0);
    });
  });

  group('AdminVehicle', () {
    test('parses fleet row with embedded current_location', () {
      final v = AdminVehicle.fromJson(const {
        'id': 1,
        'code': 'BUS-001',
        'name': 'Bluebird',
        'is_active': true,
        'created_at': '2025-01-01T00:00:00Z',
        'current_location': {
          'vehicle_id': 1,
          'vehicle_code': 'BUS-001',
          'lat': 12.97,
          'lng': 77.59,
          'speed': 10.0,
          'recorded_at': '2025-01-01T10:00:00Z',
          'status': 'idle',
        },
      });
      expect(v.currentLocation?.status, 'idle');
      expect(liveStatusOf(v.currentLocation!.status), LiveStatus.idle);
    });
  });
}
