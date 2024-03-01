class ApiError extends Error {
  final String message;

  ApiError(this.message);

  @override
  String toString() => message;
}
