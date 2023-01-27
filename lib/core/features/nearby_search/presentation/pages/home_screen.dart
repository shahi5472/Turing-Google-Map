// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/bloc/place_cubit.dart';
import 'package:turing_google_map/core/resources/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchEditController = TextEditingController(text: "restaurant");

  final Completer<GoogleMapController> _controller = Completer();

  LatLng _centerLatLng = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    _askLocationPermission();
    super.initState();
  }

  //For location permission
  void _askLocationPermission() async {
    final locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      final result = await Permission.location.request();
      if (result.isGranted) {
        _getCurrentLatLng();
      }
    } else {
      if (locationStatus.isGranted) {
        _getCurrentLatLng();
      }
    }
  }

  void _getCurrentLatLng() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showSnackBar(context, 'Location services are disabled. Please enable the services');
    } else {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _centerLatLng = LatLng(position.latitude, position.longitude);
      changeCameraPosition(_centerLatLng);
    }
  }

  void changeCameraPosition(LatLng latLng) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(latLng));
    setState(() {}); //
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void onSearchListener(String input) async {
    context.read<PlaceCubit>().nearByPlace(_centerLatLng, input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Turing Google Map"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<PlaceCubit, PlaceState>(
            builder: (context, state) {
              List<Marker> markerList = [];
              if (state is PlaceLoaded) {
                markerList.addAll(Utils.placeToMarker(state.placeList));
              }
              return GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _centerLatLng,
                  zoom: 16.0,
                ),
                onTap: changeCameraPosition,
                markers: Set<Marker>.of(markerList),
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(1, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.location_history),
                onPressed: _getCurrentLatLng,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 25,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(1, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: searchEditController,
                  onFieldSubmitted: onSearchListener,
                  decoration: const InputDecoration(
                    hintText: "Search your place",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
