import 'package:get/get.dart';

import '../modules/app_page/bindings/app_page_binding.dart';
import '../modules/app_page/views/app_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/shortcuts/bindings/shortcuts_binding.dart';
import '../modules/shortcuts/views/shortcuts_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const home = Routes.home;
  static const shortcuts = Routes.shortcuts;
  static const appPage = Routes.appPage;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.leftToRight,
      // transitionDuration: Duration(milliseconds: 600)
    ),
    GetPage(
      name: _Paths.shortcuts,
      page: () => const ShortcutsView(),
      binding: ShortcutsBinding(),
      transition: Transition.rightToLeft,
      // transitionDuration: Duration(milliseconds: 600)
    ),
    GetPage(
      name: _Paths.appPage,
      page: () => const AppPageView(),
      binding: AppPageBinding(),
    ),
  ];
}
