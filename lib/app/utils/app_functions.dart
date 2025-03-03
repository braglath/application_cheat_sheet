import 'dart:io';

import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AppFunctions {
  // Method to pick an image from the gallery
  static Future<Result> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return Result(errorMessage: "Image selection cancelled");
    }
    return Result(data: pickedFile);
  }

  // Method to resize image to 50x50
  static Future<Result> resizeImage(Uint8List imageBytes) async {
    try {
      final result = await FlutterImageCompress.compressWithList(
        imageBytes,
        minWidth: 250,
        minHeight: 250,
        quality: 100, // You can adjust the quality here
      );
      return Result(data: result);
    } catch (e) {
      return Result(errorMessage: e.toString());
    }
  }

// Method to save resized image to a temporary directory
  static Future<Result> saveResizedImage(Uint8List resizedBytes) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/resized_image.png');
      await file.writeAsBytes(resizedBytes);
      return Result(data: file);
    } catch (e) {
      return Result(errorMessage: e.toString());
    }
  }
}
