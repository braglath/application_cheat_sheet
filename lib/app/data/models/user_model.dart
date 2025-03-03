class UserModel {
  String? name;
  String? phone;

  UserModel({this.name, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}

class UserModelResult {
  final List<UserModel>? userList;
  final String? errorMessage;

  UserModelResult({this.userList, this.errorMessage});

  // Check if the result is an error
  bool get isError => errorMessage != null;
}
