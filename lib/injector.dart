import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:turing_google_map/core/features/nearby_search/data/datasoruces/place_remote_data_source.dart';
import 'package:turing_google_map/core/features/nearby_search/data/repositories/place_remote_repository_impl.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/repositories/place_repository.dart';
import 'package:turing_google_map/core/features/nearby_search/domain/usecases/place_use_case.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/home/bloc/place_cubit.dart';
import 'package:turing_google_map/core/features/nearby_search/presentation/place_detail/bloc/place_detail_cubit.dart';
import 'package:turing_google_map/core/network_checker/network_checker.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Bloc
  getIt.registerFactory<PlaceCubit>(() => PlaceCubit(getIt<PlaceUseCase>()));
  getIt.registerFactory<PlaceDetailCubit>(() => PlaceDetailCubit(getIt<PlaceUseCase>()));

  // Use cases
  getIt.registerLazySingleton<PlaceUseCase>(() => PlaceUseCase(getIt<PlaceRepository>()));

  // Repository
  getIt.registerLazySingleton<PlaceRepository>(
    () => PlaceRemoteRepositoryImpl(
      placeRemoteDataSource: getIt<PlaceRemoteDataSource>(),
      networkChecker: getIt<NetworkChecker>(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<PlaceRemoteDataSource>(() => PlaceRemoteDataSourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<Dio>(() => Dio());

  //! External
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkChecker>(() => NetworkCheckerImpl(getIt<Connectivity>()));
}
