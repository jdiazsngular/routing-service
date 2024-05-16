import 'dart:convert';

import 'package:routing_service/model/node.dart';

class GeoJsonUtils {
  static String pathToGeoJson(List<Node> path) {
    final coordinates = path
        .map((node) => [node.longitude, node.latitude, node.altitude])
        .toList();

    final geoJson = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {"type": "LineString", "coordinates": coordinates},
          "properties": {}
        }
      ]
    };

    return jsonEncode(geoJson);
  }

  static PisteType mapGeoJsonToPisteType(String value) {
    switch (value) {
      case "lift":
        return PisteType.lift;
      case "connection":
        return PisteType.connection;
      default:
        return PisteType.run;

    }
  }
}
