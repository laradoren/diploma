class Data {
  final String key;
  final dynamic value;

  const Data({
    required this.key,
    required this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      key: json['key'],
      value: json['value'],
    );
  }
}