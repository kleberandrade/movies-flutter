import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/movie.dart';

void main() {
  test('zero total pages may only describe an empty result', () {
    expect(
      () => MoviePage.fromJson({
        'page': 1,
        'total_pages': 0,
        'results': [
          {'id': 1, 'title': 'Invalid'},
        ],
      }),
      throwsFormatException,
    );
  });
  test('parses numeric scores and missing optional metadata', () {
    final movie = Movie.fromJson({
      'id': 1,
      'title': 'Orbit',
      'vote_average': 8,
      'release_date': '',
      'poster_path': null,
    });
    expect(movie.rating, 8.0);
    expect(movie.releaseDate, isNull);
    expect(movie.posterUrl, isNull);
    expect(movie.overview, isEmpty);
  });
  test('rejects broken identity, score and image paths at the boundary', () {
    for (final data in [
      {'id': 0, 'title': 'X'},
      {'id': 1, 'title': ''},
      {'id': 1, 'title': 'X', 'vote_average': 11},
      {'id': 1, 'title': 'X', 'poster_path': 'https://evil.example/a'},
    ]) {
      expect(() => Movie.fromJson(data), throwsFormatException);
    }
  });
}
