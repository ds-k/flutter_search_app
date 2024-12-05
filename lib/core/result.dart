class Result<T> {
  final T? data;
  final int? errorCode;
  final String? errorMessage;

  Result.success(this.data)
      : errorCode = null,
        errorMessage = null;

  Result.failure(this.errorCode, this.errorMessage) : data = null;

  bool get isSuccess => data != null;
  bool get isFailure => !isSuccess;
}
