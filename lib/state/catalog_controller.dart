import 'package:flutter/foundation.dart';

import '../data/movie_repository.dart';
import '../domain/movie.dart';

/// Latest search owns the state; obsolete responses cannot overwrite it.
class CatalogController extends ChangeNotifier {
  CatalogController(this.repository);
  final MovieRepository repository;
  List<Movie> _movies = [];
  List<Movie> get movies => List.unmodifiable(_movies);
  String query = '';
  String? error;
  bool loading = false;
  int _page = 0, _total = 1, _generation = 0;
  bool _disposed = false;
  bool get hasMore => _page < _total;
  void invalidateSearch() {
    _generation++;
  }

  Future<void> search(String value) async {
    query = value.trim();
    final generation = ++_generation;
    _movies = [];
    _page = 0;
    _total = 1;
    await _fetch(generation);
  }

  Future<void> loadMore() async {
    if (loading || !hasMore) return;
    await _fetch(_generation);
  }

  Future<void> _fetch(int generation) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final next = await repository.catalog(page: _page + 1, query: query);
      if (_disposed || generation != _generation) return;
      if (next.page != _page + 1) {
        throw const MovieFailure('Página inesperada. Tente novamente.');
      }
      final byId = {
        for (final movie in [..._movies, ...next.movies]) movie.id: movie,
      };
      _movies = byId.values.toList();
      _page = next.page;
      _total = next.totalPages;
    } on MovieFailure catch (failure) {
      if (!_disposed && generation == _generation) error = failure.message;
    } catch (_) {
      if (!_disposed && generation == _generation) {
        error = 'Não foi possível carregar os filmes. Tente novamente.';
      }
    } finally {
      if (!_disposed && generation == _generation) {
        loading = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    super.dispose();
  }
}
