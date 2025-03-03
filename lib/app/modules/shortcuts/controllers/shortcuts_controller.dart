import 'package:application_cheatsheets/app/data/models/app_model.dart';
import 'package:application_cheatsheets/app/data/models/shortcuts_model.dart';
import 'package:application_cheatsheets/app/data/service/database/app_shortcut_db_services.dart';
import 'package:get/get.dart';

class ShortcutsController extends GetxController {
  final AppShortcutDbService _appShortcutDb = AppShortcutDbService();

  final shortcuts = <ShortcutsModel>[].obs;
  final isLoading = false.obs;

  final Rxn<AppModel> app = Rxn<AppModel>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final AppModel appArg = Get.arguments as AppModel;
    setApp(appArg);
    if (appArg.id == null || appArg.id!.isEmpty) return;
    getAllShortcuts(appArg.id);
  }

  void setApp(AppModel? a) => app.value = a;

  void showLoader() => isLoading.value = true;

  void hideLoader() => isLoading.value = false;

  Future<void> getAllShortcuts(appName) async {
    showLoader();
    final result = await _appShortcutDb.getAllShortcuts(appName);
    if (result.isError) {
      Get.snackbar("Error", result.errorMessage ?? '');
    } else {
      shortcuts.clear();
      if (result.shortcuts != null || result.shortcuts!.isNotEmpty) {
        shortcuts.value = result.shortcuts!.toList();
      }
    }
    hideLoader();
  }

  Future<void> addShortcut(ShortcutsModel shortcut) async {
    showLoader();
    try {
      final docId =
          shortcut.title?.trim().replaceAll(' ', '').toString().toLowerCase();
      final statusResult = await _appShortcutDb.addShortcut(
          app.value?.id ?? '', docId ?? '', shortcut);
      if (statusResult.isError) {
        Get.snackbar("Error", statusResult.errorMessage.toString());
      } else {
        Get.snackbar("Success", statusResult.data.toString());
      }
    } catch (e) {
      Get.snackbar("Error", "Error: $e");
    }
    hideLoader();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
