import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/place_detail/bloc/place_detail_cubit.dart';
import 'package:turing_google_map/core/remote_urls.dart';
import 'package:turing_google_map/core/route_arguments.dart';

import '../../home/widgets/loader_view.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({Key? key, required this.args}) : super(key: key);

  final RouteArguments args;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  void initState() {
    _getPlaceDetails();
    super.initState();
  }

  void _getPlaceDetails() async {
    context.read<PlaceDetailCubit>().getPlaceDetail(widget.args.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Place Detail")),
      body: BlocBuilder<PlaceDetailCubit, PlaceDetailState>(
        builder: (context, state) {
          if (state is PlaceDetailLoaded) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                Text("Name :: ${state.placeDetail.name}"),
                const SizedBox(height: 20),
                Text("Address :: ${state.placeDetail.address}"),
                if (state.placeDetail.photoReference != null) ...[
                  const SizedBox(height: 20),
                  Image.network(
                    RemoteUrls.imageUrl(state.placeDetail.photoReference!),
                  ),
                ],
              ],
            );
          }
          if (state is PlaceError) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            );
          }
          return const LoaderView();
        },
      ),
    );
  }
}
