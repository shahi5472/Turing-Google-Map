part of 'place_cubit.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
}

class PlaceInitial extends PlaceState {
  @override
  List<Object> get props => [];
}

class PlaceLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class PlaceError extends PlaceState {
  String message;

  PlaceError(this.message);

  @override
  List<Object?> get props => [];
}

class PlaceLoaded extends PlaceState {
  List<PlaceEntity> placeList;

  PlaceLoaded(this.placeList);

  @override
  List<Object?> get props => [placeList];
}


