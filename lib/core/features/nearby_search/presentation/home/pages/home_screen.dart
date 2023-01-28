// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/home/bloc/place_cubit.dart';
import 'package:turing_google_map/core/resources/utils.dart';
import 'package:turing_google_map/core/route_arguments.dart';
import 'package:turing_google_map/core/route_name.dart';

import '../widgets/loader_view.dart';
import '../widgets/searchbar_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchEditController = TextEditingController();

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
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void onSearchListener(String input) async {
    FocusScope.of(context).unfocus();
    context.read<PlaceCubit>().nearByPlace(_centerLatLng, input.trim());
  }

  void onTap(String placeId) {
    Navigator.of(context).pushNamed(
      RouteNames.placeDetailScreen,
      arguments: RouteArguments(placeId: placeId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Turing Google Map")),
      body: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          List<Marker> markerList = [];
          if (state is PlaceLoaded) {
            markerList.addAll(Utils.placeToMarker(state.placeList, onTap: onTap));
          }
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _centerLatLng,
                  zoom: 14.0,
                ),
                onTap: changeCameraPosition,
                markers: Set<Marker>.of(markerList),
              ),
              Positioned(
                left: 20,
                right: 20,
                top: 25,
                child: SearchbarContainer(
                  controller: searchEditController,
                  onFieldSubmitted: onSearchListener,
                ),
              ),
              if (state is PlaceLoading)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: LoaderView(),
                ),
            ],
          );
        },
      ),
    );
  }
}
