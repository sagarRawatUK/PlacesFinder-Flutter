import 'package:flutter/cupertino.dart';

class ImageService extends ChangeNotifier {
  String? imgUrl;
  String? get getImgUrl => imgUrl;
  static String API_KEY = "AIzaSyC1BIF3FT3LKxcGLg6Uf1bkHWIpgdbtf2A";

  String fetchImage(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$API_KEY";
  }
}
