class LocationEntity {
  PlusCode plusCode;
  List<Result> results;
  String status;

  LocationEntity(this.plusCode, this.results, this.status);
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode(this.compoundCode, this.globalCode);
}

class Result {
  String formattedAddress;
  Geometry geometry;
  String placeId;
  List<AddressComponent> addressComponents;
  List<String> types;

  Result(this.formattedAddress, this.geometry, this.placeId, this.addressComponents, this.types);
}

class Geometry {
  Location location;
  String locationType;
  Viewport viewport;
  Bounds bounds;

  Geometry(this.location, this.locationType, this.viewport, this.bounds);
}

class Location {
  double lat;
  double lng;

  Location(this.lat, this.lng);
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport(this.northeast, this.southwest);
}

class Bounds {
  Location northeast;
  Location southwest;

  Bounds(this.northeast, this.southwest);
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent(this.longName, this.shortName, this.types);
}
