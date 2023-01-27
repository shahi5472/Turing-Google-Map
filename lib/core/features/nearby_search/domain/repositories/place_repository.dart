import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:turing_google_map/core/error/failure.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PlaceRepository {
  Future<Either<Failure, List<PlaceEntity>>> getNearbyPlace(LatLng latLng, String type);

  Future<Either<Failure, PlaceEntity>> getPlaceDetail(String placeId);
}
