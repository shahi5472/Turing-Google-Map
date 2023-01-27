import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:turing_google_map/models/nearby_response_model.dart';

const mapKey = "AIzaSyCONLzKdcEAm5KZBaOKFxMS3L4VGb27wGo";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turing Google Map',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Dio _dio = Dio();
  TextEditingController searchEditController = TextEditingController(text: "restaurant");

  final Completer<GoogleMapController> _controller = Completer();

  LatLng _center = const LatLng(45.521563, -122.677433);

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
      showSnackBar('Location services are disabled. Please enable the services');
    } else {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("_getCurrentLatLng :: ${position.latitude}/${position.longitude}");
      _center = LatLng(position.latitude, position.longitude);
      changeCameraPosition(_center);
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

  List<Marker> markerList = [];
  List<Results> mapResult = [];

  void onSearchListener(String input) async {
    String address = input.replaceAllMapped(' ', (m) => '+');
    // final url = "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$mapKey&language=en";
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_center.latitude},${_center.longitude}&radius=300&key=$mapKey&language=en';

    print("onSearchListener :: $url");
    try {
      final response = await _dio.get(url);
      print("onSearchListener :: ${response.data}");
      NearbyResponseModel model = NearbyResponseModel.fromJson(response.data);
      if (model.status == "OK" && model.results != null) {
        mapResult.addAll(model.results!);
        for (final map in model.results!) {
          changeCameraPosition(LatLng(map.geometry!.location!.lat!.toDouble(), map.geometry!.location!.lng!.toDouble()));
          print("Map :: ${map.geometry?.location?.toJson()}");
          markerList.add(
            Marker(
              markerId: MarkerId(map.placeId.toString()),
              position: LatLng(map.geometry!.location!.lat!.toDouble(), map.geometry!.location!.lng!.toDouble()),
              infoWindow: InfoWindow(
                title: "${map.name}",
                snippet: '${map.types?[0]}',
              ),
              onTap: () {
                //navigator
              },
            ),
          );
        }
      } else {
        showSnackBar("No result found");
      }
      setState(() {});
    } catch (e) {
      print("Error :: $e");
    }
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
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.0,
            ),
            onTap: changeCameraPosition,
            markers: Set<Marker>.of(markerList),
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
          if (mapResult.isNotEmpty)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final value = mapResult[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(int.tryParse(value.iconBackgroundColor!.replaceAll("#", "0xFF"))!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(value.name ?? ""),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemCount: mapResult.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
