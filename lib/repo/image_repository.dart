import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/ImageEntity.dart';

class ImageRepository {
  Future<List<ImageEntity>> getNetworkImages() async {
    // FIXME error handling
    try {
      final parsedURI = Uri.parse('https://pixelford.com/api2/images');
      final res = await http.get(parsedURI);

      if (res.statusCode == 200) {
        final List decodedRes = jsonDecode(res.body) as List;

        List<ImageEntity> pixelfordImages =
            decodedRes.map((el) => ImageEntity.fromJson(el)).toList();
        return pixelfordImages;
      } else {
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      throw Exception('Failed to load Data catch');
    }
  }
}
