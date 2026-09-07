import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth_requests.dart';
import '../models/token_pair.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<TokenPair> login(@Body() LoginRequest body);

  @POST('/auth/refresh')
  Future<TokenPair> refresh(@Body() RefreshRequest body);
}
