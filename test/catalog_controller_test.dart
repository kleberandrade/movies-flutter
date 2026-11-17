import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/movie_repository.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/state/catalog_controller.dart';

class PendingRepository implements MovieRepository {
  final requests = <({int page, String query, Completer<MoviePage> result})>[];
  @override
  bool get isDemo => true;
  @override
  Future<MoviePage> catalog({int page = 1, String query = ''}) {
    final result = Completer<MoviePage>();
    requests.add((page: page, query: query, result: result));
    return result.future;
  }

  @override
  Future<Movie> detail(int id) => throw UnimplementedError();
}

Movie movie(int id) => Movie.fromJson({'id': id, 'title': 'Film $id'});
MoviePage page(int number, List<int> ids) =>
    MoviePage(page: number, totalPages: 2, movies: ids.map(movie).toList());
void main() {
  test('latest query wins even when old request completes last', () async {
    final repo = PendingRepository();
    final state = CatalogController(repo);
    final old = state.search('old');
    final latest = state.search('new');
    repo.requests[1].result.complete(page(1, [2]));
    await latest;
    repo.requests[0].result.complete(page(1, [1]));
    await old;
    expect(state.query, 'new');
    expect(state.movies.single.id, 2);
    expect(state.loading, false);
    state.dispose();
  });
  test('prevents duplicate page requests, deduplicates movies and stops at last page', () async {
    final repo = PendingRepository();
    final state = CatalogController(repo);
    final first = state.search('');
    await state.loadMore();
    expect(repo.requests.length, 1);
    repo.requests[0].result.complete(page(1, [1, 2]));
    await first;
    final next = state.loadMore();
    expect(repo.requests[1].page, 2);
    repo.requests[1].result.complete(page(2, [2, 3]));
    await next;
    expect(state.movies.map((m) => m.id), [1, 2, 3]);
    expect(state.hasMore, false);
    await state.loadMore();
    expect(repo.requests.length, 2);
    state.dispose();
  });
  test(
    'failed next page preserves items and retry requests the same page',
    () async {
      final repo = PendingRepository();
      final state = CatalogController(repo);
      final first = state.search('');
      repo.requests[0].result.complete(page(1, [1]));
      await first;
      final next = state.loadMore();
      repo.requests[1].result.completeError(const MovieFailure('offline'));
      await next;
      expect(state.movies.single.id, 1);
      expect(state.error, 'offline');
      expect(state.loading, false);
      final retry = state.loadMore();
      expect(repo.requests.last.page, 2);
      repo.requests.last.result.complete(page(2, [2]));
      await retry;
      expect(state.error, isNull);
      state.dispose();
    },
  );
  test('typing invalidates old response before debounce dispatch and dispose is safe', () async {
    final repo = PendingRepository();
    final state = CatalogController(repo);
    final old = state.search('');
    state.invalidateSearch();
    repo.requests[0].result.complete(page(1, [1]));
    await old;
    expect(state.movies, isEmpty);
    final latest = state.search('latest');
    state.dispose();
    repo.requests.last.result.complete(page(1, [2]));
    await latest;
  });
}
