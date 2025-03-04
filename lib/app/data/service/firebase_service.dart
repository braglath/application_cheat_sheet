import 'package:application_cheatsheets/app/utils/logger_utils';
import 'package:application_cheatsheets/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  // Initialize Firebase
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Additional initialization logic (e.g., logging)
    checkUserStatus();
  }

  static void checkUserStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      LoggerUtils.i("user is not signed in");
    }
  }
}
