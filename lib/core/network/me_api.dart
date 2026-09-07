import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/assignment.dart';
import '../models/history.dart';
import '../models/route_polyline.dart';
import '../models/user_profile.dart';
import '../models/vehicle_live.dart';

part 'me_api.g.dart';

@RestApi()
abstract class MeApi {
  factory MeApi(Dio dio, {String? baseUrl}) = _MeApi;

  @GET('/me/profile')
  Future<UserProfile> getProfile();

  @GET('/me/assignment')
  Future<Assignment> getAssignment();

  @GET('/me/route')
  Future<RoutePolyline> getRoute();

  @GET('/me/vehicle/current')
  Future<VehicleLive> getVehicleCurrent();

  @GET('/me/vehicle/history')
  Future<HistoryOut> getVehicleHistory({
    // Nullable WITHOUT defaults: Retrofit serializes every non-null param,
    // and the backend rejects empty from/to strings (422 validation_error).
    // Leave from/to null to omit them entirely.
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });
}
