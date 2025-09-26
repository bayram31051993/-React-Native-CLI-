class ModelToiList {
  static List<T> listFromJson<T>(
    List<dynamic> list,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return List<T>.from(list.map((x) => fromJson(x)));
  }
}
