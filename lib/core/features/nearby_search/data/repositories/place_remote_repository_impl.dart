import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:turing_google_map/core/error/failure.dart';
import 'package:turing_google_map/core/features/nearby_search/data/datasoruces/place_remote_data_source.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/repositories/place_repository.dart';
import 'package:turing_google_map/core/features/nearby_search/mapper/place_mapper.dart';
import 'package:turing_google_map/core/network_checker/network_checker.dart';

class PlaceRemoteRepositoryImpl extends PlaceRepository {
  final NetworkChecker networkChecker;
  PlaceRemoteDataSource placeRemoteDataSource;

  PlaceRemoteRepositoryImpl({
    required this.networkChecker,
    required this.placeRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<PlaceEntity>>> getNearbyPlace(LatLng latLng, String type) async {
    if (await networkChecker.isConnected()) {
      try {
        final result = await placeRemoteDataSource.getNearbyPlace(latLng, type);
        return Right(PlaceMapper.placeNearByModelToEntity(result));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure("No Internet connection"));
    }
  }

  @override
  Future<Either<Failure, PlaceEntity>> getPlaceDetail(String placeId) async {
    if (await networkChecker.isConnected()) {
      try {
        final result = await placeRemoteDataSource.getPlaceDetail(placeId);
        return Right(PlaceMapper.placeDetailsModelToEntity(result));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure("No Internet connection"));
    }
  }
}
