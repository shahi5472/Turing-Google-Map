import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static List<Marker> placeToMarker(List<PlaceEntity> placeList, {Function(String)? onTap}) {
    List<Marker> markerList = [];
    for (final place in placeList) {
      markerList.add(
        Marker(
          markerId: MarkerId(place.placeId ?? ""),
          position: place.latLng ?? const LatLng(0.0, 0.0),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address ?? "Lat: ${place.latLng?.latitude}\nLng: ${place.latLng?.longitude}",
          ),
          onTap: place.placeId != null ? () => onTap?.call(place.placeId!) : null,
        ),
      );
    }
    return markerList;
  }
}
