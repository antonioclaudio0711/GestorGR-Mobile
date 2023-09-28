class ApiResponse<T> {
  ApiResponse({
    this.isOK,
    this.message,
    this.result,
  });

  bool? isOK;
  String? message;
  T? result;

  ApiResponse.ok(this.result) {
    isOK = true;
  }

  ApiResponse.error(this.message) {
    isOK = false;
  }
}
