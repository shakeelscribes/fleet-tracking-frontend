import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'admin_api.dart';
import 'auth_api.dart';
import 'dio_provider.dart';
import 'me_api.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) => AuthApi(ref.watch(dioClientProvider));

@Riverpod(keepAlive: true)
MeApi meApi(Ref ref) => MeApi(ref.watch(dioClientProvider));

@Riverpod(keepAlive: true)
AdminApi adminApi(Ref ref) => AdminApi(ref.watch(dioClientProvider));
