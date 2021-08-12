import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';

class PlacesService extends ChangeNotifier {
  Location? userLocation;
  Location? get getUserLocation => userLocation;
  String? searchQuery;
  String? get getSearchQuery => searchQuery;
  PlacesSearchResponse? placesSearchResponse;
  PlacesSearchResponse? get getPlacesSearcheResponse => placesSearchResponse;

  final places =
      GoogleMapsPlaces(apiKey: "AIzaSyC1BIF3FT3LKxcGLg6Uf1bkHWIpgdbtf2A");

  Future<PlacesSearchResponse> fetchNearbyPlaces(String searchQuery) async {
    searchQuery = searchQuery;
    PlacesSearchResponse _response = await places
        .searchNearbyWithRadius(userLocation!, 10000, type: searchQuery);
    placesSearchResponse = _response;
    notifyListeners();
    return _response;
  }
}
