import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/entities/place_entity.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/usecases/place_use_case.dart';

part 'place_detail_state.dart';

class PlaceDetailCubit extends Cubit<PlaceDetailState> {
  final PlaceUseCase _useCase;

  PlaceDetailCubit(this._useCase) : super(PlaceDetailInitial());

  Future<void> getPlaceDetail(String placeId) async {
    emit(PlaceLoading());
    final result = await _useCase.getPlaceDetail(placeId);
    result.fold(
      (failure) => emit(PlaceError(failure.message)),
      (data) => emit(PlaceDetailLoaded(data)),
    );
  }
}
