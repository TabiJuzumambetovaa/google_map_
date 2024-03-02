part of 'geolocation_cubit.dart';

@immutable
sealed class GeolocationState {}

final class GeolocationInitial extends GeolocationState {

}
final class GeolocationLoading extends GeolocationState {
  
}
final class GeolocationSuccess extends GeolocationState {
  final GeolocationModel model;
  GeolocationSuccess({required this.model});
  
}
final class GeolocationError extends GeolocationState {
  
}
