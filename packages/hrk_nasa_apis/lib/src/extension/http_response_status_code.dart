extension HttpResponseStatusCode on int {
  bool is2xx() {
    return this >= 200 && this <= 299;
  }

  bool is3xx() {
    return this >= 300 && this <= 399;
  }

  bool is4xx() {
    return this >= 400 && this <= 499;
  }
}
