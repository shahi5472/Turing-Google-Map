import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:turing_google_map/core/error/failure.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/repositories/place_repository.dart';

class PlaceUseCase {
  PlaceRepository placeRepository;

  PlaceUseCase(this.placeRepository);

  Future<Either<Failure, List<PlaceEntity>>> nearByPlace(LatLng latLng, String type) async {
    return await placeRepository.getNearbyPlace(latLng, type);
  }

  Future<Either<Failure, PlaceEntity>> getPlaceDetail(String placeId) async {
    return await placeRepository.getPlaceDetail(placeId);
  }
}
