import 'package:application_cheatsheets/app/data/models/app_model.dart';
import 'package:application_cheatsheets/app/modules/add_app/views/add_app_view.dart';
import 'package:application_cheatsheets/app/routes/app_pages.dart';
import 'package:application_cheatsheets/app/widgets/glossy_card.dart';
import 'package:application_cheatsheets/app/widgets/loader.dart';
import 'package:application_cheatsheets/app/widgets/search_with_fab.dart';
import 'package:application_cheatsheets/app/widgets/texts/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeadingText("Apps"),
      ),
      // bottomNavigationBar: CustomTextField(label: "Search", onChanged: (v) {}),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(children: [Apps()]),
                  SearchAndFab(),
                ],
              ),
              Loader<HomeController>(),
            ],
          ),
        ),
      ),
    );
  }
}

class Apps extends StatelessWidget {
  const Apps({super.key});

  HomeController get controller => GetInstance().find<HomeController>();

  @override
  Widget build(BuildContext context) => Obx(() {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust this for more or fewer items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1),
          itemCount: controller.filteredApps.length,
          itemBuilder: (context, index) =>
              AppCard(controller.filteredApps[index]),
        );
      });
}

class AppCard extends StatelessWidget {
  final AppModel app;

  const AppCard(this.app, {super.key});

  @override
  Widget build(BuildContext context) => Hero(
        tag: app.id.toString(),
        child: Material(
          type: MaterialType.transparency,
          child: GlossyCard(
            imageUrl: app.url,
            onTap: () => Get.toNamed(AppPages.shortcuts, arguments: app),
            name: app.name ?? '',
          ),
        ),
      );
}

class SearchAndFab extends StatelessWidget {
  const SearchAndFab({super.key});

  HomeController get controller => GetInstance().find<HomeController>();

  void showAddAppDialog() async {
    final appIds =
        controller.allApps.map((e) => e.id).whereType<String>().toList();

    final appNames =
        controller.allApps.map((e) => e.name).whereType<String>().toList();

    final result = await Get.dialog(
      Dialog(
          child: AddAppView(
        appIds: appIds,
        appNames: appNames,
      )),
    );

    if (result != null) {
      final app = AppModel(
          id: result['appId'],
          isDisabled: false,
          name: result['appName'],
          url: result['appImageUrl']);

      controller.showLoader();
      controller.addAppToDb(app: app).whenComplete(() {
        controller.onReady();
        controller.hideLoader();
      });
    }
  }

  @override
  Widget build(BuildContext context) => SearchWithFab(
        onFabPressed: showAddAppDialog,
        onTextFieldChanged: controller.setSearchText,
        textLabel: "Search Apps",
      );
}
//     () async {
//   /*
//   final String name = "Braglath Sreekumar  ";
//
//   final String phone = "9840620323";
//   final String nameFormatted =
//       name.trim().toLowerCase().replaceAll(" ", "_");
//
//   await controller.addUserToDb(
//     // Add a document
//     customId:
//         '${nameFormatted}_${DateTime.now().millisecondsSinceEpoch}',
//     user: UserModel(name: name.trim(), phone: phone),
//   );
//   */
// },
