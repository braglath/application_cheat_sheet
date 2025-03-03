import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Singleton instance
  FirestoreService._internal();

  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  // Firestore instance
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String userCollection = 'users';
  final String appsCollection = 'apps';
  final String shortcuts = 'shortcuts';
}
