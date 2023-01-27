import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/usecases/place_use_case.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  final PlaceUseCase _useCase;

  PlaceCubit(this._useCase) : super(PlaceInitial());

  Future<void> nearByPlace(LatLng latLng, String type) async {
    final result = await _useCase.nearByPlace(latLng, type);
    result.fold(
      (failure) => emit(PlaceError(failure.message)),
      (data) => emit(PlaceLoaded(data)),
    );
  }
}
