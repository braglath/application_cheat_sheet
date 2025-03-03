import 'dart:io';

import 'package:http/http.dart' as http;

class ImageApi {
  final String _url = 'https://api.imgur.com/3/image';
  final String _clientId = '606a35030361439';

  Future<http.Response> uploadImage(File file) async {
    try {
      var headers = {'Authorization': 'Client-ID $_clientId'};
      var request = http.MultipartRequest('POST', Uri.parse(_url));
      request.fields.addAll({
        'type': 'image',
        'title': 'Excel',
        'description': 'This is an excel icon',
      });
      request.files.add(await http.MultipartFile.fromPath('image', file.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return await http.Response.fromStream(response);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
