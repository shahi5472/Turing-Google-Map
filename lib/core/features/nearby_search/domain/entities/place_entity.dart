import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class PlaceEntity extends Equatable {
  String? name;
  LatLng? latLng;
  String? placeId;
  String? address;
  String? photoReference;
  double? width;

  PlaceEntity({this.name, this.latLng, this.placeId, this.address, this.photoReference, this.width});

  @override
  List<Object?> get props => [name, latLng, placeId, address, photoReference, width];

  @override
  String toString() {
    return "Name : $name :: Lat : ${latLng?.latitude}, Lng : ${latLng?.longitude} :: Place : $placeId :: Address : $address :: Photo Reference : $photoReference :: Width : $width";
  }
}
