import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class PlaceEntity extends Equatable {
  String? name;
  LatLng? latLng;
  String? placeId;
  String? address;

  PlaceEntity({this.name, this.latLng, this.placeId, this.address});

  @override
  List<Object?> get props => [name, latLng, placeId, address];

  @override
  String toString() {
    return "Name : $name :: Lat : ${latLng?.latitude}, Lng : ${latLng?.longitude} :: Place : $placeId :: Address : $address";
  }
}
