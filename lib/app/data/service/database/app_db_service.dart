import 'package:application_cheatsheets/app/data/models/app_model.dart';
import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_service.dart';

class AppDbService {
  final FirestoreService _firestoreService = FirestoreService();

  FirebaseFirestore get db => _firestoreService.db;

  String get _appsCollection => _firestoreService.appsCollection;

  // Add a document to a collection
  Future<Result> addApp(AppModel app) async {
    try {
      await db.collection(_appsCollection).doc(app.id).set(app.toJson());
      return Result(data: "App added successfully");
    } catch (e) {
      print('Error adding app: $e');
      return Result(errorMessage: e.toString());
    }
  }

  // Get all documents from a collection
  Future<AppModelResult> getApps() async {
    try {
      QuerySnapshot snapshot = await db.collection(_appsCollection).get();
      final dataList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      // dataList.forEach((a) {
      //   print(a.toString());
      // });
      if (dataList.isEmpty) {
        return AppModelResult(appList: []);
      } else {
        List<AppModel> users =
            dataList.map((userData) => AppModel.fromJson(userData)).toList();
        return AppModelResult(appList: users);
      }
    } catch (e) {
      print('Error fetching documents: $e');
      return AppModelResult(errorMessage: 'Error: $e');
    }
  }

  // Update a document in a collection
  // Future<void> updateApp(
  //     String documentId, Map<String, dynamic> updatedData) async {
  //   try {
  //     await db.collection(appsCollection).doc(documentId).update(updatedData);
  //   } catch (e) {
  //     print('Error updating document: $e');
  //   }
  // }
  //
  // // Delete a document from a collection
  // Future<void> deleteApps(String documentId) async {
  //   try {
  //     await db.collection(appsCollection).doc(documentId).delete();
  //   } catch (e) {
  //     print('Error deleting document: $e');
  //   }
  // }
}
