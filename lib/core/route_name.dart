import 'package:flutter/material.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/home/pages/home_screen.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/place_detail/pages/place_details_screen.dart';
import 'package:turing_google_map/core/route_arguments.dart';

class RouteNames {
  static const String homeScreen = '/';
  static const String placeDetailScreen = '/place-detail-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.placeDetailScreen:
        final args = settings.arguments as RouteArguments;
        return MaterialPageRoute(builder: (_) => PlaceDetailScreen(args: args));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.red,
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
