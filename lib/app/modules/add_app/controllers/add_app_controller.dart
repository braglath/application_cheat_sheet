import 'dart:io';

import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:application_cheatsheets/app/data/repository/image_repo.dart';
import 'package:application_cheatsheets/app/utils/app_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AddAppController extends GetxController {
  final isLoading = false.obs;

  final appId = ''.obs; // Observable for App ID
  final appName = ''.obs; // Observable for App Name

  final appImageUrl = ''.obs;
  final Rxn<String> appIdErrorText = Rxn<String>();
  final Rxn<String> appNameErrorText = Rxn<String>();

  final ImageRepository _imageRepository = ImageRepository();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void showLoader() => isLoading.value = true;

  // Method to turn the loader off
  void hideLoader() => isLoading.value = false;
  void setAppId(String id) {
    appId.value = id;
  }

  void setAppName(String name) {
    appName.value = name;
  }

// Method to upload image to a server
  Future<void> uploadImageToServer(File file) async {
    final Result result = await _imageRepository.uploadImage(file);
    if (result.isError) {
      Get.snackbar("Error", result.errorMessage ?? '');
    } else {
      appImageUrl.value = result.data;
    }
  }

// Main method that coordinates the image picking, resizing, and uploading
  Future<void> uploadImage() async {
    try {
      // Pick image from the gallery
      final Result result = await AppFunctions.pickImageFromGallery();
      if (result.isError) {
        print(result.errorMessage);
        return;
      }

      final pickedFile = result.data;
      // Read the image as bytes
      File imageFile = File(pickedFile.path);
      Uint8List bytes = await imageFile.readAsBytes();

      // Resize the image to 50x50
      final Result imageResult = await AppFunctions.resizeImage(bytes);
      if (imageResult.isError) {
        print(imageResult.errorMessage);
        return;
      }

      final resizedBytes = imageResult.data;
      // Save the resized image to a temp file
      final Result resizedImageFileResult =
          await AppFunctions.saveResizedImage(resizedBytes);
      if (resizedImageFileResult.isError) {
        print(resizedImageFileResult.errorMessage);
        return;
      }

      final resizedImageFile = resizedImageFileResult.data;
      // Upload the resized image
      await uploadImageToServer(resizedImageFile);
    } catch (e) {
      print('Error: $e');
    }
  }

  void setAppIdError(String? err) => appIdErrorText.value = err;
  void setAppNameError(String? err) => appNameErrorText.value = err;

  @override
  void onClose() {
    super.onClose();
    hideLoader();
  }
}
