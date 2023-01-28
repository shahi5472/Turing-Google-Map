import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_google_map/core/features/nearby_search/data/models/nearby_response_model.dart';
import 'package:turing_google_map/core/features/nearby_search/data/models/place_detail_response_model.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';

class PlaceMapper {
  static List<PlaceEntity> placeNearByModelToEntity(NearbyResponseModel nearbyResponseModel) {
    return nearbyResponseModel.results?.map((place) {
          final lat = place.geometry?.location?.lat?.toDouble();
          final lng = place.geometry?.location?.lng?.toDouble();
          return PlaceEntity(
            name: place.name,
            placeId: place.placeId,
            latLng: LatLng(lat ?? 0, lng ?? 0),
          );
        }).toList() ??
        [];
  }

  static PlaceEntity placeDetailsModelToEntity(PlaceDetailResponseModel placeDetailResponseModel) {
    final result = placeDetailResponseModel.result;
    final lat = result?.geometry?.location?.lat?.toDouble();
    final lng = result?.geometry?.location?.lng?.toDouble();
    final photo = result?.photos?.take(1).first;
    return PlaceEntity(
      name: result?.name,
      latLng: LatLng(lat ?? 0, lng ?? 0),
      placeId: result?.placeId,
      address: result?.formattedAddress,
      photoReference: photo?.photoReference,
      width: photo?.width?.toDouble() ?? 0,
    );
  }
}
