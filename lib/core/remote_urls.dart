import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_google_map/.env.dart';

class RemoteUrls {
  static const radius = "300";

  static const String domainName = "https://maps.googleapis.com/maps/api/place";

  static String nearbyPlaceApi(LatLng latLng, String type) => "$domainName/nearbysearch/json?location=${latLng.latitude},${latLng.longitude}&radius=$radius&key=${Env.mapKey}";

  static String placeDetailApi(String placeId) => "$domainName/details/json?place_id=$placeId&key=${Env.mapKey}";

  static String imageUrl(String input) {
    return 'https://openweathermap.org/img/wn/$input@2x.png';
  }
}
