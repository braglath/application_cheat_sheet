import 'package:cloud_firestore/cloud_firestore.dart';

class ShortcutsModel {
  String? keyBinding;
  String? keyCombination;
  String? description;
  int? id;
  String? title;
  DateTime? dateAdded;

  ShortcutsModel({
    this.keyCombination,
    this.keyBinding,
    this.description,
    this.id,
    this.title,
    this.dateAdded,
  });

  ShortcutsModel.fromJson(Map<String, dynamic> json) {
    keyBinding = json['key_binding'];
    keyCombination = json['key_combination'];
    description = json['description'];
    id = json['id'];
    title = json['title'];
    dateAdded = json['date_added'] is Timestamp
        ? (json['date_added'] as Timestamp).toDate()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key_binding'] = keyBinding;
    data['key_combination'] = keyCombination;
    data['description'] = description;
    data['id'] = id;
    data['title'] = title;
    data['date_added'] =
        dateAdded != null ? Timestamp.fromDate(dateAdded!) : null;
    return data;
  }
}

class ShortcutsModelResult {
  final List<ShortcutsModel>? shortcuts;
  final String? errorMessage;

  ShortcutsModelResult({this.shortcuts, this.errorMessage});

  // Check if the result is an error
  bool get isError => errorMessage != null;
}
