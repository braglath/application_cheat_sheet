import 'package:application_cheatsheets/app/data/models/app_model.dart';
import 'package:get/get.dart';

class AppPageController extends GetxController {
  final Rxn<AppModel> app = Rxn<AppModel>();

  @override
  void onInit() {
    super.onInit();
    final AppModel appArg = Get.arguments as AppModel;
    setApp(appArg);
  }

  void setApp(AppModel? a) => app.value = a;
}
