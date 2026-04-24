class FoodMediaDecoded {
  final String? uri;
  final String? type;
  final String? group;
  final String? url;

  FoodMediaDecoded({
    this.uri,
    this.type,
    this.group,
    this.url,
  });

  factory FoodMediaDecoded.fromJson(Map<String, dynamic> json) {
    return FoodMediaDecoded(
      uri: json['uri'],
      type: json['type'],
      group: json['group'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uri": uri,
      "type": type,
      "group": group,
      "url": url,
    };
  }
}
