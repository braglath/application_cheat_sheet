import 'package:application_cheatsheets/app/data/service/firebase_service.dart';
import 'package:application_cheatsheets/app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.home,
      getPages: AppPages.routes,
      theme: AppThemes.light,
    ),
  );
}
