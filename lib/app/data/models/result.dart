class Result {
  final dynamic data;
  final String? errorMessage;

  Result({this.data, this.errorMessage});

  // Check if the result is an error
  bool get isError => errorMessage != null;
}
