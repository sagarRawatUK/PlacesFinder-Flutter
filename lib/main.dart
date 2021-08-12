import 'package:findmyplace/backend/provider/fetch_image.dart';
import 'package:findmyplace/backend/provider/filter_service.dart';
import 'package:findmyplace/frontend/screens/home.dart';
import 'package:findmyplace/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/provider/places_service.dart';

void main() {
  runApp(FindMyPlace());
}

class FindMyPlace extends StatelessWidget {
  const FindMyPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlacesService()),
        ChangeNotifierProvider(create: (_) => ImageService()),
        ChangeNotifierProvider(create: (_) => FilterService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: PageRoutes().routes(),
        theme: ThemeData(
          checkboxTheme: CheckboxThemeData(),
          unselectedWidgetColor: Colors.grey[400],
        ),
      ),
    );
  }
}
