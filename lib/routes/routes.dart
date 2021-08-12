import 'package:findmyplace/frontend/screens/filter_screen.dart';
import 'package:findmyplace/frontend/screens/home.dart';
import 'package:findmyplace/frontend/screens/nearby_places.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const home = 'home_page';
  static const nearbyPlaces = 'nearby_places';
  static const filter = 'filter_page';

  Map<String, WidgetBuilder> routes() {
    return {
      home: (context) => HomePage(),
      nearbyPlaces: (context) => NearbyPlaces(),
      filter: (context) => FilterPage(),
    };
  }
}
