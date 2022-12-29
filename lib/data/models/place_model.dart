class PlaceModel {
  List<Features>? features;

  PlaceModel({this.features});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? text;
  String? placeName;
  Geometry? geometry;
  List<Context>? context;

  Features({this.text, this.placeName, this.geometry, this.context});

  Features.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    placeName = json['place_name'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    if (json['context'] != null) {
      context = <Context>[];
      json['context'].forEach((v) {
        context!.add(Context.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['place_name'] = placeName;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    if (context != null) {
      data['context'] = context!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Geometry {
  List<double>? coordinates;

  Geometry({this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coordinates'] = coordinates;
    return data;
  }
}

class Context {
  String? id;
  String? text;
  String? wikidata;
  String? shortCode;

  Context({this.id, this.text, this.wikidata, this.shortCode});

  Context.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    wikidata = json['wikidata'];
    shortCode = json['short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['wikidata'] = wikidata;
    data['short_code'] = shortCode;
    return data;
  }
}
