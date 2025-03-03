class AppModel {
  String? id;
  bool? isDisabled;
  String? name;
  String? url;

  AppModel({this.id, this.isDisabled, this.name, this.url});

  AppModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDisabled = json['isDisabled'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isDisabled'] = isDisabled;
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppModel &&
        other.id == id &&
        other.isDisabled == isDisabled &&
        other.name == name &&
        other.url == url;
  }

  // Override hashCode
  @override
  int get hashCode {
    return id.hashCode ^ isDisabled.hashCode ^ name.hashCode ^ url.hashCode;
  }
}

class AppModelResult {
  final List<AppModel>? appList;
  final String? errorMessage;

  AppModelResult({this.appList, this.errorMessage});

  // Check if the result is an error
  bool get isError => errorMessage != null;
}
