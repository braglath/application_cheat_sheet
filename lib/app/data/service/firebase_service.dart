import 'package:application_cheatsheets/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  // Initialize Firebase
  static Future<void> initialize() async => await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
// Additional initialization logic (e.g., logging) can go here
}
