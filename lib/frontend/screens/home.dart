import 'package:findmyplace/backend/provider/places_service.dart';
import 'package:findmyplace/frontend/screens/nearby_places.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Marker> markers = [];

  Future<Position>? currentPosition;
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  addMarker(LatLng coordinates) {
    setState(() {
      markers.add(
        Marker(
          position: coordinates,
          markerId: MarkerId("Current Location"),
        ),
      );
    });
  }

  void getCurrentLocation() {
    currentPosition = GeolocatorPlatform.instance.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentPosition,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Getting Location ...",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 90,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.green[100],
                      color: Color(0xff0FC874),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          Position snapshotData = snapshot.data;
          Provider.of<PlacesService>(context, listen: false).userLocation =
              Location(lat: snapshotData.latitude, lng: snapshotData.longitude);
          // LatLng _userLocation =
          //     LatLng(snapshotData.latitude, snapshotData.longitude);
          return NearbyPlaces();
          // return Scaffold(
          //   body: Stack(
          //     alignment: Alignment.bottomCenter,
          //     children: [
          //       GoogleMap(
          //         zoomControlsEnabled: false,
          //         compassEnabled: true,
          //         initialCameraPosition: CameraPosition(
          //             zoom: 16,
          //             target: LatLng(
          //                 _userLocation.latitude, _userLocation.longitude)),
          //         onMapCreated: (controller) {
          //           setState(() {
          //             _googleMapController = controller;
          //             addMarker(LatLng(
          //                 _userLocation.latitude, _userLocation.longitude));
          //           });
          //         },
          //         markers: markers.toSet(),
          //         onTap: (coordinates) {
          //           _googleMapController!.animateCamera(
          //               CameraUpdate.newCameraPosition(
          //                   CameraPosition(target: coordinates, zoom: 16)));
          //           addMarker(coordinates);
          //         },
          //       ),
          //       GestureDetector(
          //         onTap: () =>
          //             Navigator.pushNamed(context, PageRoutes.nearbyPlaces),
          //         child: Container(
          //           height: 50,
          //           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: Color(0xff0FC874),
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           child: Center(
          //               child: Text(
          //             "See nearby places",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w600),
          //           )),
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        }
        return Center(
          child: Text(
            "Network Error",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
