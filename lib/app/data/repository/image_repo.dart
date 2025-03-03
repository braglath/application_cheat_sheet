import 'dart:io';

import 'package:application_cheatsheets/app/data/models/result.dart';
import 'package:application_cheatsheets/app/data/service/image_service.dart';

class ImageRepository {
  final ImageService _imageService = ImageService();

  Future<Result> uploadImage(File file) async =>
      await _imageService.uploadImage(file);
}
