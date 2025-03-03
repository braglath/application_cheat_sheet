import 'dart:convert';
import 'dart:io';

import 'package:application_cheatsheets/app/data/api/image_api.dart';
import 'package:application_cheatsheets/app/data/models/image_upload_model.dart';
import 'package:application_cheatsheets/app/data/models/result.dart';

class ImageService {
  final ImageApi _imageApi = ImageApi();

  Future<Result> uploadImage(File file) async {
    try {
      final response = await _imageApi.uploadImage(file);

      if (response.statusCode == 200) {
        // Optionally, you could process the response further,
        // for example extracting a URL or other data from the response.
        print(response.body);
        // convert response.body to model
        final Map<String, dynamic> data = json.decode(response.body);
        final finalData = ImageUploadModel.fromJson(data);
        if (finalData.data == null ||
            finalData.data!.link == null ||
            finalData.data!.link!.isEmpty) {
          return Result(errorMessage: "Failed to upload image");
        }
        return Result(data: finalData.data!.link ?? '');
      } else {
        return Result(errorMessage: 'Failed to upload image');
      }
    } catch (e) {
      return Result(errorMessage: e.toString());
    }
  }
}
