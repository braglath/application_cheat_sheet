import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:application_cheatsheets/app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_service.dart';

class UserDbService {
  final FirestoreService _firestoreService = FirestoreService();

  FirebaseFirestore get db => _firestoreService.db;

  String get _userCollection => _firestoreService.userCollection;

  // Add a document to a collection
  Future<Result> addUser(String customId, UserModel user) async {
    try {
      await db.collection(_userCollection).doc(customId).set(user.toJson());
      return Result();
    } catch (e) {
      print('Error adding document: $e');
      return Result(errorMessage: e.toString());
    }
  }

  // Get all documents from a collection
  Future<UserModelResult> getUsers() async {
    try {
      QuerySnapshot snapshot = await db.collection(_userCollection).get();
      final dataList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      if (dataList.isEmpty) {
        return UserModelResult(userList: []);
      } else {
        List<UserModel> users =
            dataList.map((userData) => UserModel.fromJson(userData)).toList();
        return UserModelResult(userList: users);
      }
    } catch (e) {
      print('Error fetching documents: $e');
      return UserModelResult(errorMessage: 'Error: $e');
    }
  }

  // Update a document in a collection
  // Future<void> updateDocument(
  //     String documentId, Map<String, dynamic> updatedData) async {
  //   try {
  //     await db.collection(userCollection).doc(documentId).update(updatedData);
  //   } catch (e) {
  //     print('Error updating document: $e');
  //   }
  // }
  //
  // // Delete a document from a collection
  // Future<void> deleteDocument(String documentId) async {
  //   try {
  //     await db.collection(userCollection).doc(documentId).delete();
  //   } catch (e) {
  //     print('Error deleting document: $e');
  //   }
  // }
}
