class KeyValuePairModel<T, R, S> {
  KeyValuePairModel({
    required this.key,
    required this.value,
    this.extra,
  });

  T key;
  R value;
  T? extra;
}
