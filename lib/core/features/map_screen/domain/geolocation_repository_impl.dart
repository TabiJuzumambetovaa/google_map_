import 'package:flutter_google_map/core/features/map_screen/data/models/location_by_address_model.dart';
import 'package:flutter_google_map/core/features/map_screen/data/models/location_model.dart';
import 'package:flutter_google_map/core/features/map_screen/data/repositories/geolocation_repository.dart';
import 'package:flutter_google_map/core/features/map_screen/domain/get_location_data_use_case.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationRepositoryImpl implements GeolocationRepository{
  GeolocationRepositoryImpl({required this.useCase});
  final GetLocationDataUseCase useCase;
  @override
  Future<GeolocationModel> getLocationByLatLng(LatLng latLng)async {
    return await useCase.getLocation(latLng);
  }
  
  @override
  Future<LocationByAddressModel> getLocationByAddress(String address) {
    return useCase.getLocationByAddress(address:address);
  }
  
}