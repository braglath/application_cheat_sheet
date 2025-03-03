import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:application_cheatsheets/app/data/models/shortcuts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_service.dart';

class AppShortcutDbService {
  final FirestoreService _firestoreService = FirestoreService();

  FirebaseFirestore get _db => _firestoreService.db;

  String get _appsCollection => _firestoreService.appsCollection;

  String get _shortcuts => _firestoreService.shortcuts;

  // Add a document to a collection
  // Future<Result> addApp(String customId, AppModel app) async {
  //   try {
  //     await db.collection(appsCollection).doc(customId).set(app.toJson());
  //     return Result();
  //   } catch (e) {
  //     print('Error adding app: $e');
  //     return Result(errorMessage: e.toString());
  //   }
  // }

  Future<ShortcutsModelResult> getAllShortcuts(String appName) async {
    try {
      // Reference to the 'apps > [appName] > shortcuts' collection
      var snapshot = await _db
          .collection(_appsCollection)
          .doc(
              appName) // This dynamically fetches the correct app collection (e.g., 'excel' or 'word')
          .collection(_shortcuts) // 'shortcuts' collection under each app
          .get(); // Get the documents

      // Convert the fetched documents into a list of maps (List<Map<String, dynamic>>)
      List<Map<String, dynamic>> shortcutsList =
          snapshot.docs.map((doc) => doc.data()).toList();

      if (shortcutsList.isEmpty) {
        return ShortcutsModelResult(shortcuts: []);
      } else {
        List<ShortcutsModel> shortcuts = shortcutsList
            .map((userData) => ShortcutsModel.fromJson(userData))
            .toList();
        return ShortcutsModelResult(shortcuts: shortcuts);
      }
    } catch (e) {
      print("Error fetching shortcuts: $e");
      return ShortcutsModelResult(
          errorMessage:
              'Error: $e'); // Return an empty list if there is an error
    }
  }

  Future<Result> addShortcut(
      String appName, String docId, ShortcutsModel shortcut) async {
    try {
      // Reference to the 'apps > [appName] > shortcuts' collection
      var shortcutsCollection =
          _db.collection(_appsCollection).doc(appName).collection(_shortcuts);

      // Add the new shortcut to Firestore
      await shortcutsCollection.doc(docId).set(shortcut.toJson());

      return Result(data: "Shortcut added successfully");
    } catch (e) {
      return Result(data: "Error adding shortcut: $e");
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
