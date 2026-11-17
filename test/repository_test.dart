import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/movie_repository.dart';

class Adapter implements HttpClientAdapter {
  Adapter(this.respond);
  final Future<ResponseBody> Function(RequestOptions) respond;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => respond(options);
  @override
  void close({bool force = false}) {}
}

Dio client(Future<ResponseBody> Function(RequestOptions) respond) =>
    Dio()..httpClientAdapter = Adapter(respond);
ResponseBody jsonResponse(Object data, [int status = 200]) =>
    ResponseBody.fromString(
      jsonEncode(data),
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
final sample =
    jsonDecode(File('assets/fixtures/movies.json').readAsStringSync()) as List;

void main() {
  test(
    'demo fixture paginates, searches, and opens matching details',
    () async {
      final demo = DemoRepository(load: () async => jsonEncode(sample));
      final first = await demo.catalog();
      final second = await demo.catalog(page: 2);
      expect(first.movies.length, 6);
      expect(second.movies.first.id, 7);
      expect(first.totalPages, 2);
      expect(
        (await demo.catalog(query: 'FAROL')).movies.single.title,
        'O último farol',
      );
      expect((await demo.catalog(query: 'missing')).movies, isEmpty);
      expect((await demo.detail(1)).runtime, 92);
      final movies = [...first.movies, ...second.movies];
      expect(movies.map((movie) => movie.posterAsset).toSet(), hasLength(12));
      for (final movie in movies) {
        expect(movie.posterUrl, isNull);
        expect(movie.posterAsset, isNotNull);
        expect(File(movie.posterAsset!).existsSync(), isTrue);
        expect((await demo.detail(movie.id)).posterAsset, movie.posterAsset);
      }
      await expectLater(demo.detail(99), throwsA(isA<MovieFailure>()));
    },
  );
  test(
    'live client sends bearer auth, encoded search, language, and page',
    () async {
      final dio = client((options) async {
        expect(options.path, '/search/movie');
        expect(options.headers['Authorization'], 'Bearer test-only');
        expect(options.queryParameters, containsPair('query', 'a & b'));
        expect(options.queryParameters['page'], 2);
        expect(options.queryParameters['language'], 'pt-BR');
        return jsonResponse({
          'page': 2,
          'total_pages': 3,
          'results': sample.take(1).toList(),
        });
      });
      final repo = TmdbRepository(token: 'test-only', dio: dio);
      expect(
        (await repo.catalog(query: ' a & b ', page: 2)).movies.single.id,
        1,
      );
    },
  );
  test('popular and detail use separate endpoints', () async {
    final paths = <String>[];
    final repo = TmdbRepository(
      token: 'test-only',
      dio: client((options) async {
        paths.add(options.path);
        return jsonResponse(
          options.path == '/movie/1'
              ? sample.first
              : {'page': 1, 'total_pages': 2, 'results': sample},
        );
      }),
    );
    await repo.catalog();
    expect((await repo.detail(1)).title, 'Além da órbita');
    expect(paths, ['/movie/popular', '/movie/1']);
  });
  for (final status in [401, 403, 404, 429, 500]) {
    test(
      'HTTP $status produces a safe user failure without server content',
      () async {
        final repo = TmdbRepository(
          token: 'test-only',
          dio: client(
            (_) async => jsonResponse({'status_message': 'SECRET'}, status),
          ),
        );
        await expectLater(
          repo.catalog(),
          throwsA(
            isA<MovieFailure>().having(
              (e) => e.message,
              'safe message',
              isNot(contains('SECRET')),
            ),
          ),
        );
      },
    );
  }
  for (final type in [
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError,
  ]) {
    test('$type is recoverable and human-readable', () async {
      final repo = TmdbRepository(
        token: 'test-only',
        dio: client(
          (o) async => throw DioException(requestOptions: o, type: type),
        ),
      );
      await expectLater(
        repo.catalog(),
        throwsA(
          isA<MovieFailure>().having(
            (e) => e.message,
            'message',
            contains(
              type == DioExceptionType.connectionError ? 'internet' : 'demorou',
            ),
          ),
        ),
      );
    });
  }
  test('malformed responses and mismatched detail ids are rejected', () async {
    final repo = TmdbRepository(
      token: 'test-only',
      dio: client((_) async => jsonResponse(sample.first)),
    );
    await expectLater(repo.catalog(), throwsA(isA<MovieFailure>()));
    await expectLater(repo.detail(2), throwsA(isA<MovieFailure>()));
    expect(() => TmdbRepository(token: ' '), throwsArgumentError);
    await expectLater(repo.catalog(page: 501), throwsArgumentError);
  });
}
