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
            Provider.of<FilterService>(context, listen: false).getFilters[0]
                ? FutureBuilder(
                    future: Provider.of<PlacesService>(context, listen: false)
                        .fetchNearbyPlaces("gym"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.5),
                            child: CircularProgressIndicator(
                              color: Color(0xff0FC874),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        PlacesSearchResponse snapshotData = snapshot.data;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
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
                              // height: 220,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  placeData.photos.isNotEmpty
                                      ? Expanded(
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      Provider.of<ImageService>(
                                                              context,
                                                              listen: false)
                                                          .fetchImage(
                                                        placeData.photos.first
                                                            .photoReference,
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            // height: 175,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/placeholder.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          placeData.name,
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          placeData.types.first,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.5),
                          child: Text(
                            "Network Error",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
            Provider.of<FilterService>(context, listen: false).getFilters[1]
                ? FutureBuilder(
                    future: Provider.of<PlacesService>(context, listen: false)
                        .fetchNearbyPlaces("cafe"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.5),
                            child: CircularProgressIndicator(
                              color: Color(0xff0FC874),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        PlacesSearchResponse snapshotData = snapshot.data;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
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
                              // height: 220,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  placeData.photos.isNotEmpty
                                      ? Expanded(
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      Provider.of<ImageService>(
                                                              context,
                                                              listen: false)
                                                          .fetchImage(
                                                        placeData.photos.first
                                                            .photoReference,
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            // height: 175,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/placeholder.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          placeData.name,
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          placeData.types.first,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.5),
                          child: Text(
                            "Network Error",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
            Provider.of<FilterService>(context, listen: false).getFilters[2]
                ? FutureBuilder(
                    future: Provider.of<PlacesService>(context, listen: false)
                        .fetchNearbyPlaces("restaurant"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.5),
                            child: CircularProgressIndicator(
                              color: Color(0xff0FC874),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        PlacesSearchResponse snapshotData = snapshot.data;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
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
                              // height: 220,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  placeData.photos.isNotEmpty
                                      ? Expanded(
                                          child: Container(
                                            height: 175,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      Provider.of<ImageService>(
                                                              context,
                                                              listen: false)
                                                          .fetchImage(
                                                        placeData.photos.first
                                                            .photoReference,
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            // height: 175,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/placeholder.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          placeData.name,
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          placeData.types.first,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.5),
                          child: Text(
                            "Network Error",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
            !(Provider.of<FilterService>(context, listen: false)
                        .getFilters[0] ||
                    Provider.of<FilterService>(context, listen: false)
                        .getFilters[1] ||
                    Provider.of<FilterService>(context, listen: false)
                        .getFilters[2])
                ? FutureBuilder(
                    future: Provider.of<PlacesService>(context, listen: false)
                        .fetchNearbyPlaces("store"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.5),
                            child: CircularProgressIndicator(
                              color: Color(0xff0FC874),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        PlacesSearchResponse snapshotData = snapshot.data;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshotData.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            var placeData = snapshotData.results[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(5)),
                              width: double.infinity,
                              // height: 220,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  placeData.photos.isNotEmpty
                                      ? Expanded(
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      Provider.of<ImageService>(
                                                              context,
                                                              listen: false)
                                                          .fetchImage(
                                                        placeData.photos.first
                                                            .photoReference,
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            // height: 175,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/placeholder.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          placeData.name,
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          placeData.types.first,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.5),
                          child: Text(
                            "Network Error",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
