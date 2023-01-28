part of 'place_detail_cubit.dart';

abstract class PlaceDetailState extends Equatable {
  const PlaceDetailState();
}

class PlaceDetailInitial extends PlaceDetailState {
  @override
  List<Object> get props => [];
}

class PlaceDetailLoaded extends PlaceDetailState {
  PlaceEntity placeDetail;

  PlaceDetailLoaded(this.placeDetail);

  @override
  List<Object?> get props => [placeDetail];
}

class PlaceLoading extends PlaceDetailState {
  @override
  List<Object?> get props => [];
}

class PlaceError extends PlaceDetailState {
  String message;

  PlaceError(this.message);

  @override
  List<Object?> get props => [];
}
