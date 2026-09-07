// Error-mapping tests: Dio -> AppException (skill EH-2/EH-4).
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fleet_tracker/core/errors/app_exception.dart';
import 'package:fleet_tracker/core/errors/error_mapper.dart';

void main() {
  DioException dioError(int? status, {Object? data}) => DioException(
    requestOptions: RequestOptions(path: '/x'),
    response: Response(
      requestOptions: RequestOptions(path: '/x'),
      statusCode: status,
      data: data,
    ),
  );

  group('mapDioException', () {
    test('connection error -> network', () {
      final e = mapDioException(
        DioException(
          requestOptions: RequestOptions(path: '/x'),
          type: DioExceptionType.connectionError,
        ),
      );
      expect(e, isA<NetworkException>());
    });

    test('backend envelope 403 no_assignment -> forbidden with message', () {
      final e = mapDioException(
        dioError(
          403,
          data: {
            'error': {
              'code': 'no_assignment',
              'message': 'No route or vehicle assigned',
            },
          },
        ),
      );
      expect(e, isA<ForbiddenException>());
      final f = e as ForbiddenException;
      expect(f.code, 'no_assignment');
      expect(f.message, 'No route or vehicle assigned');
    });

    test('401 -> unauthorized', () {
      expect(mapDioException(dioError(401)), isA<UnauthorizedException>());
    });

    test('404 -> notFound', () {
      expect(mapDioException(dioError(404)), isA<NotFoundException>());
    });

    test('422 envelope -> server with code passthrough', () {
      final e = mapDioException(
        dioError(
          422,
          data: {
            'error': {'code': 'validation_error', 'message': 'bad input'},
          },
        ),
      );
      final s = e as ServerException;
      expect(s.code, 'validation_error');
    });
  });
}
