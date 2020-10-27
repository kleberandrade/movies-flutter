abstract class MovieError implements Exception {
  String message;

  @override
  String toString() {
    return message;
  }
}

class MovieRepositoryError extends MovieError {
  MovieRepositoryError(String message) {
    this.message = message;
  }
}
