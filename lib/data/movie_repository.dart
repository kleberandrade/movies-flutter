import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../domain/movie.dart';

abstract interface class MovieRepository {
  bool get isDemo;
  Future<MoviePage> catalog({int page = 1, String query = ''});
  Future<Movie> detail(int id);
}

class MovieFailure implements Exception {
  const MovieFailure(this.message);
  final String message;
  @override
  String toString() => message;
}

class TmdbRepository implements MovieRepository {
  TmdbRepository({required String token, Dio? dio}) : _dio = dio ?? Dio() {
    if (token.trim().isEmpty) throw ArgumentError('TMDB_TOKEN is required');
    _dio.options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization': 'Bearer ${token.trim()}',
        'Accept': 'application/json',
      },
    );
  }
  final Dio _dio;
  @override
  bool get isDemo => false;

  Future<Object?> _get(String path, [Map<String, dynamic>? query]) async {
    try {
      return (await _dio.get<Object?>(
        path,
        queryParameters: {'language': 'pt-BR', ...?query},
      )).data;
    } on DioException catch (error) {
      final message = switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout =>
          'A conexão demorou demais. Tente novamente.',
        DioExceptionType.connectionError =>
          'Sem conexão. Verifique sua internet e tente novamente.',
        _ => switch (error.response?.statusCode) {
          401 ||
          403 => 'Acesso ao TMDB recusado. Confira a configuração do token.',
          404 => 'Filme não encontrado.',
          429 => 'Muitas consultas. Aguarde um momento e tente novamente.',
          _ => 'Não foi possível acessar o TMDB. Tente novamente.',
        },
      };
      throw MovieFailure(message);
    }
  }

  @override
  Future<MoviePage> catalog({int page = 1, String query = ''}) async {
    if (page < 1 || page > 500) throw ArgumentError.value(page, 'page');
    final search = query.trim();
    try {
      return MoviePage.fromJson(
        await _get(search.isEmpty ? '/movie/popular' : '/search/movie', {
          'page': page,
          if (search.isNotEmpty) 'query': search,
          'include_adult': false,
        }),
      );
    } on FormatException {
      throw const MovieFailure(
        'O TMDB retornou dados inválidos. Tente novamente.',
      );
    }
  }

  @override
  Future<Movie> detail(int id) async {
    if (id <= 0) throw ArgumentError.value(id, 'id');
    try {
      final movie = Movie.fromJson(objectJson(await _get('/movie/$id')));
      if (movie.id != id) throw const FormatException('Mismatched movie');
      return movie;
    } on FormatException {
      throw const MovieFailure(
        'O TMDB retornou dados inválidos. Tente novamente.',
      );
    }
  }
}

/// Original fictional teaching data. Never a fallback for a failed live request.
class DemoRepository implements MovieRepository {
  DemoRepository({Future<String> Function()? load})
    : _load =
          load ?? (() => rootBundle.loadString('assets/fixtures/movies.json'));
  final Future<String> Function() _load;
  Future<List<Movie>>? _cache;
  @override
  bool get isDemo => true;
  Future<List<Movie>> _movies() => _cache ??= _read();
  Future<List<Movie>> _read() async {
    try {
      final data = jsonDecode(await _load());
      if (data is! List) throw const FormatException('Expected sample list');
      return data.map((item) => Movie.fromJson(objectJson(item))).toList();
    } catch (_) {
      _cache = null;
      throw const MovieFailure('Não foi possível abrir os dados de exemplo.');
    }
  }

  @override
  Future<MoviePage> catalog({int page = 1, String query = ''}) async {
    if (page < 1 || page > 500) throw ArgumentError.value(page, 'page');
    final all = (await _movies())
        .where(
          (m) => m.title.toLowerCase().contains(query.trim().toLowerCase()),
        )
        .toList();
    const size = 6;
    final pages = (all.length / size).ceil();
    return MoviePage(
      page: page,
      totalPages: pages,
      movies: all.skip((page - 1) * size).take(size).toList(),
    );
  }

  @override
  Future<Movie> detail(int id) async {
    for (final movie in await _movies()) {
      if (movie.id == id) return movie;
    }
    throw const MovieFailure('Filme não encontrado.');
  }
}
