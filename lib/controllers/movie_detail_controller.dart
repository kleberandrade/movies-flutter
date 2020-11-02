import 'package:dartz/dartz.dart';

import '../errors/movie_error.dart';
import '../models/movie_detail_model.dart';
import '../repositories/movie_repository.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  MovieDetailModel movieDetail;
  MovieError movieError;

  bool loading = true;

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    movieError = null;
    final result = await _repository.fetchMovieById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => movieDetail = detail,
    );
    return result;
  }
}
