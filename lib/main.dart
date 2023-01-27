import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/bloc/place_cubit.dart';
import 'package:turing_google_map/core/route_name.dart';
import 'injector.dart' as injector;

const mapKey = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlaceCubit>(
          create: (BuildContext context) => injector.getIt<PlaceCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Turing Google Map',
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: RouteNames.generateRoute,
      ),
    );
  }
}
