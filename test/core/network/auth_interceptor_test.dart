import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_tools_app/core/network/auth_interceptor.dart';
import 'package:it_tools_app/core/storage/token_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

class MockDio extends Mock implements Dio {}

class MockRequestHandler extends Mock implements RequestInterceptorHandler {}

class MockErrorHandler extends Mock implements ErrorInterceptorHandler {}

void main() {
  late MockTokenStorage mockStorage;
  late MockDio mockRefreshDio;
  late AuthInterceptor interceptor;
  late bool sessionExpiredCalled;

  setUp(() {
    mockStorage = MockTokenStorage();
    mockRefreshDio = MockDio();
    sessionExpiredCalled = false;

    interceptor = AuthInterceptor(
      tokenStorage: mockStorage,
      refreshDio: mockRefreshDio,
      onSessionExpired: () => sessionExpiredCalled = true,
    );
  });

  group('AuthInterceptor Tests', () {
    test('adds Authorization header when access token exists', () async {
      when(() => mockStorage.readAccessToken())
          .thenAnswer((_) async => 'sample_access_token');

      final options = RequestOptions(path: '/products');
      final handler = MockRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers['Authorization'], 'Bearer sample_access_token');
      verify(() => handler.next(options)).called(1);
    });

    test(
      'does not add Authorization header when access token is null',
      () async {
        when(() => mockStorage.readAccessToken()).thenAnswer((_) async => null);

        final options = RequestOptions(path: '/products');
        final handler = MockRequestHandler();

        await interceptor.onRequest(options, handler);

        expect(options.headers.containsKey('Authorization'), isFalse);
        verify(() => handler.next(options)).called(1);
      },
    );

    test(
      'clears tokens and triggers guest mode on 401 when refresh fails',
      () async {
        when(() => mockStorage.readRefreshToken())
            .thenAnswer((_) async => 'expired_refresh_token');
        when(() => mockStorage.clear()).thenAnswer((_) async {});
        when(
          () => mockRefreshDio.post(any(), data: any(named: 'data')),
        ).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/auth/refresh')),
        );

        final requestOptions = RequestOptions(path: '/orders');
        final err = DioException(
          requestOptions: requestOptions,
          response: Response(requestOptions: requestOptions, statusCode: 401),
        );
        final handler = MockErrorHandler();

        await interceptor.onError(err, handler);

        verify(() => mockStorage.clear()).called(1);
        expect(sessionExpiredCalled, isTrue);
        verify(() => handler.next(err)).called(1);
      },
    );
  });
}
