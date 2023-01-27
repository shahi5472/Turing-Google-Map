import 'dart:convert';

NearbyResponseModel nearbyResponseModelFromJson(String str) => NearbyResponseModel.fromJson(json.decode(str));

String nearbyResponseModelToJson(NearbyResponseModel data) => json.encode(data.toJson());

class NearbyResponseModel {
  NearbyResponseModel({
    this.nextPageToken,
    this.results,
    this.status,
  });

  NearbyResponseModel.fromJson(dynamic json) {
    nextPageToken = json['next_page_token'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  String? nextPageToken;
  List<Results>? results;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['next_page_token'] = nextPageToken;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));

String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.scope,
    this.types,
    this.vicinity,
  });

  Results.fromJson(dynamic json) {
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
    vicinity = json['vicinity'];
  }

  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  String? reference;
  String? scope;
  List<String>? types;
  String? vicinity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    map['icon'] = icon;
    map['icon_background_color'] = iconBackgroundColor;
    map['icon_mask_base_uri'] = iconMaskBaseUri;
    map['name'] = name;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = placeId;
    map['reference'] = reference;
    map['scope'] = scope;
    map['types'] = types;
    map['vicinity'] = vicinity;
    return map;
  }
}

Photos photosFromJson(String str) => Photos.fromJson(json.decode(str));

String photosToJson(Photos data) => json.encode(data.toJson());

class Photos {
  Photos({
    this.height,
    this.photoReference,
    this.width,
  });

  Photos.fromJson(dynamic json) {
    height = json['height'];
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  num? height;
  String? photoReference;
  num? width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = height;
    map['photo_reference'] = photoReference;
    map['width'] = width;
    return map;
  }
}

Geometry geometryFromJson(String str) => Geometry.fromJson(json.decode(str));

String geometryToJson(Geometry data) => json.encode(data.toJson());

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Geometry.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }

  Location? location;
  Viewport? viewport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (viewport != null) {
      map['viewport'] = viewport?.toJson();
    }
    return map;
  }
}

Viewport viewportFromJson(String str) => Viewport.fromJson(json.decode(str));

String viewportToJson(Viewport data) => json.encode(data.toJson());

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(dynamic json) {
    northeast = json['northeast'] != null ? Northeast.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? Southwest.fromJson(json['southwest']) : null;
  }

  Northeast? northeast;
  Southwest? southwest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (northeast != null) {
      map['northeast'] = northeast?.toJson();
    }
    if (southwest != null) {
      map['southwest'] = southwest?.toJson();
    }
    return map;
  }
}

Southwest southwestFromJson(String str) => Southwest.fromJson(json.decode(str));

String southwestToJson(Southwest data) => json.encode(data.toJson());

class Southwest {
  Southwest({
    this.lat,
    this.lng,
  });

  Southwest.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  num? lat;
  num? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

Northeast northeastFromJson(String str) => Northeast.fromJson(json.decode(str));

String northeastToJson(Northeast data) => json.encode(data.toJson());

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  Northeast.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  num? lat;
  num? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  num? lat;
  num? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}
