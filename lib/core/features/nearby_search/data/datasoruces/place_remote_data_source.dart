import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_google_map/core/features/nearby_search/data/models/nearby_response_model.dart';
import 'package:turing_google_map/core/features/nearby_search/data/models/place_detail_response_model.dart';
import 'package:turing_google_map/core/remote_urls.dart';

abstract class PlaceRemoteDataSource {
  Future<NearbyResponseModel> getNearbyPlace(LatLng latLng, String type);

  Future<PlaceDetailResponseModel> getPlaceDetail(String placeId);
}

class PlaceRemoteDataSourceImpl extends PlaceRemoteDataSource {
  final Dio _dio;

  PlaceRemoteDataSourceImpl(this._dio);

  @override
  Future<NearbyResponseModel> getNearbyPlace(LatLng latLng, String type) async {
    try {
      final url = RemoteUrls.nearbyPlaceApi(latLng, type);
      log(url);
      final response = await _dio.get(url);
      log(response.statusMessage.toString());
      log(response.data.toString());
      log(response.statusCode.toString());
      return nearbyResponseModelFromJson(response.data.toString());
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<PlaceDetailResponseModel> getPlaceDetail(String placeId) async {
    try {
      final url = RemoteUrls.placeDetailApi(placeId);
      final response = await _dio.get(url);
      return PlaceDetailResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
