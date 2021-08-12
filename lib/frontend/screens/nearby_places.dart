import 'package:findmyplace/backend/provider/fetch_image.dart';
import 'package:findmyplace/backend/provider/filter_service.dart';
import 'package:findmyplace/backend/provider/places_service.dart';
import 'package:findmyplace/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

// GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class NearbyPlaces extends StatefulWidget {
  @override
  _NearbyPlacesState createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  bool selectAll = false;
  List<bool> checkBoxes = [false, false, false];
  String? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      // endDrawer: MyDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff0FC874)),
                borderRadius: BorderRadius.circular(5)),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.filter);
                // scaffoldKey.currentState!.openEndDrawer();
              },
              child: Center(
                child: Row(
                  children: [
                    Text("Filter ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0FC874))),
                    Text(
                      Provider.of<FilterService>(context, listen: true)
                          .getFilterCount
                          .toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView(
          children: [
            FutureBuilder(
              future: Provider.of<PlacesService>(context, listen: false)
                  .fetchNearbyPlaces(
                      Provider.of<FilterService>(context, listen: false)
                          .getQuery!),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff0FC874),
                    ),
                  );
                } else if (snapshot.hasData) {
                  PlacesSearchResponse snapshotData = snapshot.data;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshotData.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      var placeData = snapshotData.results[index];
                      if (placeData.photos.isNotEmpty) {}
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(3)),
                        width: double.infinity,
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            placeData.photos.isNotEmpty
                                ? Container(
                                    height: 175,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              Provider.of<ImageService>(context,
                                                      listen: false)
                                                  .fetchImage(
                                                placeData.photos.first
                                                    .photoReference,
                                              ),
                                            ),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    height: 175,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/placeholder.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.grey)
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    placeData.name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    placeData.types.first,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Text(
                    "Network Error",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
