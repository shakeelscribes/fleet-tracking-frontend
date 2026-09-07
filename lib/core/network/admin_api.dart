import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/admin_vehicle.dart';

part 'admin_api.g.dart';

@RestApi()
abstract class AdminApi {
  factory AdminApi(Dio dio, {String? baseUrl}) = _AdminApi;

  @GET('/admin/vehicles')
  Future<List<AdminVehicle>> listVehicles();
}
