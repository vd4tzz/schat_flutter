sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(String message, String? code) failure,
  });

  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String message, String? code)? failure,
  });

  factory Result.success(T data) => Success(data);
  factory Result.failure(String message, [String? code]) =>
      Failure(message, code);
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, String? code) failure,
  }) => success(data);

  @override
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String message, String? code)? failure,
  }) => success?.call(data);
}

class Failure<T> extends Result<T> {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, String? code) failure,
  }) => failure(message, code);

  @override
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String message, String? code)? failure,
  }) => failure?.call(message, code);
}
