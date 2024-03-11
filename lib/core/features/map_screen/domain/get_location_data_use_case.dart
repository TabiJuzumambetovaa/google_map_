import 'package:dio/dio.dart';
import 'package:flutter_google_map/core/config/api_routes.dart';
import 'package:flutter_google_map/core/consts/app_const.dart';
import 'package:flutter_google_map/core/features/map_screen/data/models/location_by_address_model.dart';
import 'package:flutter_google_map/core/features/map_screen/data/models/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationDataUseCase {
  GetLocationDataUseCase({required this.dio});
  final Dio dio;
  Future<GeolocationModel> getLocation(LatLng latLng) async {
    final Response response = await dio.get(ApiRoutes.goCade, queryParameters: {
      "key": AppConst.apiKey,
      "latlng": "${latLng.latitude},${latLng.longitude}"
    }
    
    );
    return GeolocationModel.fromJson(response.data);
  }

  Future<LocationByAddressModel> getLocationByAddress({required String address})async{
    final Response response=await dio.post(ApiRoutes.goCade,queryParameters: {
      "address":"Бишкек+${address.replaceAll(" ", "+")}",
      "key":AppConst.apiKey,
    });
    return LocationByAddressModel.fromJson(response.data);
  }
}
