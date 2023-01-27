// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:turing_google_map/models/map_response_model.dart';
// import 'package:turing_google_map/core/features/nearby_search/data/models/place_detail_response_model.dart';
//
// import '../../main.dart';
//
// class PlaceDetailsScreen extends StatefulWidget {
//   const PlaceDetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
// }
//
// class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
//   late Results arguments;
//
//   final Dio _dio = Dio();
//
//   String? title;
//   String? address;
//
//   @override
//   void initState() {
//     arguments = ModalRoute.of(context)?.settings.arguments as Results;
//     super.initState();
//     getPlaceDetails();
//   }
//
//   void getPlaceDetails() async {
//     String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=${arguments.placeId}&key=$mapKey";
//     final response = await _dio.get(url);
//     PlaceDetailResponseModel model = PlaceDetailResponseModel.fromJson(response.data);
//     if (model.status == "OK") {
//       setState(() {
//         title = model.result?.name;
//         address = model.result?.formattedAddress;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Place Details")),
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//           Text("Title: $title"),
//           Text("Address: $address"),
//         ],
//       ),
//     );
//   }
// }
