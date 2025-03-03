import 'package:application_cheatsheets/app/data/models/app_model.dart';
import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:application_cheatsheets/app/data/service/database/app_db_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AppDbService _appDb = AppDbService();

  final isLoading = false.obs;
  final allApps = <AppModel>[].obs;
  final filteredApps = <AppModel>[].obs;

  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    ever(allApps, (e) => filterApps(""));
    ever(searchText, filterApps);
  }

  @override
  void onReady() {
    super.onReady();
    getApps();
  }

  Future<void> getApps() async {
    showLoader();
    final result = await _appDb.getApps();
    if (result.isError) {
      Get.snackbar("Error", result.errorMessage ?? '');
    } else {
      if (result.appList != null || result.appList!.isNotEmpty) {
        allApps.value = result.appList!.toList();
      }
    }
    hideLoader();
  }

  void showLoader() => isLoading.value = true;
  void hideLoader() => isLoading.value = false;

  Future<void> addAppToDb({required AppModel app}) async {
    try {
      final Result res = await _appDb.addApp(app);
      if (res.isError) {
        Get.snackbar("Error", res.errorMessage ?? '');
      } else {
        Get.snackbar("Success", res.data);
      }
    } catch (e) {
      Get.snackbar("Error", 'Error adding app: $e');
    }
  }

  void setSearchText(String search) => searchText.value = search;

  void filterApps(String search) {
    print("search: $search");
    if (search.isEmpty) {
      filteredApps.value = allApps;
    } else {
      filteredApps.value = allApps.where((app) {
        print("app name: ${app.name}");
        print(app.name!.toLowerCase().contains(search.toLowerCase()));
        return app.name!.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
