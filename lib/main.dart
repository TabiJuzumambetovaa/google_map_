import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_map/core/config/dio_settings.dart';
import 'package:flutter_google_map/core/features/map_screen/domain/geolocation_repository_impl.dart';
import 'package:flutter_google_map/core/features/map_screen/domain/get_location_data_use_case.dart';
import 'package:flutter_google_map/core/features/map_screen/presentation/cubit/geolocation_cubit.dart';
import 'package:flutter_google_map/core/features/map_screen/presentation/screens/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DioSettings(),
          ),
          RepositoryProvider(
            create: (context) => GetLocationDataUseCase(
                dio: RepositoryProvider.of<DioSettings>(context).dio),
          ),
          RepositoryProvider(
            create: (context) => GeolocationRepositoryImpl(
                useCase:
                    RepositoryProvider.of<GetLocationDataUseCase>(context)),
          ),
        ],
        child: BlocProvider(
          create: (context) => GeolocationCubit(repository: RepositoryProvider.of<GeolocationRepositoryImpl>(context)),
          child: const MyHomePage(),
        ),
      ),
    );
  }
}
