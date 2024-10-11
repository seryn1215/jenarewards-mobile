class Result<T> {
  Result._();

  factory Result.success(T value) = Success<T>;
  factory Result.failure(String message) = Failure<T>;
}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value) : super._();
}

class Failure<T> extends Result<T> {
  final String message;

  Failure(this.message) : super._();
}

class ApiError {
  ApiError({required this.error});

  final String error;
}
