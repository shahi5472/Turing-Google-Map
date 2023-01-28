import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_google_map/.env.dart';

class RemoteUrls {
  static const radius = "2000";

  static const String domainName = "https://maps.googleapis.com/maps/api/place";

  static String nearbyPlaceApi(LatLng latLng, String type) => "$domainName/nearbysearch/json?location=${latLng.latitude}%2C${latLng.longitude}&radius=$radius&type=$type&key=${Env.mapKey}";

  static String placeDetailApi(String placeId) => "$domainName/details/json?place_id=$placeId&key=${Env.mapKey}";

  static String imageUrl(String photoRef, {int width = 400}) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=$width&photo_reference=$photoRef&key=${Env.mapKey}';
  }
}
