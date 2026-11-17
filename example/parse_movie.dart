import 'package:movies/domain/movie.dart';

void main() {
  final movie = Movie.fromJson({
    'id': 1,
    'title': 'Exemplo local',
    'vote_average': 8,
    'poster_path': null,
    'release_date': '',
  });
  // Printing is the observable output of this standalone teaching example.
  // ignore: avoid_print
  print(
    '${movie.title} • ${movie.rating.toStringAsFixed(1)}/10 • ${movie.year}',
  );
}
