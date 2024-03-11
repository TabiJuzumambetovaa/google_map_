import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_map/core/features/map_screen/data/models/location_by_address_model.dart';
import 'package:flutter_google_map/core/features/map_screen/data/models/location_model.dart';
import 'package:flutter_google_map/core/features/map_screen/data/repositories/geolocation_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit({required this.repository}) : super(GeolocationInitial());
  final GeolocationRepository repository;
    Future<void> getLocationByLatLng(LatLng latLng)async{
    emit(GeolocationLoading());
    try{
      final GeolocationModel model=await repository.getLocationByLatLng(latLng);
      emit(GeolocationSuccess(geolocationModel: model));
    }catch(e){
      emit(GeolocationError());
    }

  }
  Future<void> getLocationByAddress(String address)async{
    emit(GeolocationLoading());
    try{
      final LocationByAddressModel model=await repository.getLocationByAddress(address);
      emit(GeolocationSuccess(locationByAddressModel: model));
    }catch(e){
      emit(GeolocationError());
    }

  }
}
