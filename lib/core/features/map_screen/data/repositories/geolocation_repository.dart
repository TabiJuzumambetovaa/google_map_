
import 'package:flutter_google_map/core/features/map_screen/data/models/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GeolocationRepository{
  Future<GeolocationModel> getLocationByLatLng(LatLng latLng);
}