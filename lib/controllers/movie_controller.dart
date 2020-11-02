import 'package:dartz/dartz.dart';

import '../errors/movie_error.dart';
import '../models/movie_model.dart';
import '../models/movie_response_model.dart';
import '../repositories/movie_repository.dart';

class MovieController {
  final _repository = MovieRepository();

  MovieResponseModel movieResponseModel;
  MovieError movieError;
  bool loading = true;

  List<MovieModel> get movies => movieResponseModel?.movies ?? <MovieModel>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieResponseModel?.totalPages ?? 1;
  int get currentPage => movieResponseModel?.page ?? 1;

  Future<Either<MovieError, MovieResponseModel>> fetchAllMovies(
      {int page = 1}) async {
    movieError = null;
    final result = await _repository.fetchAllMovies(page);
    result.fold(
      (error) => movieError = error,
      (movie) {
        if (movieResponseModel == null) {
          movieResponseModel = movie;
        } else {
          movieResponseModel.page = movie.page;
          movieResponseModel.movies.addAll(movie.movies);
        }
      },
    );

    return result;
  }
}
