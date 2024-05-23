import 'dart:convert';

import 'package:routing_service/service/route_algorithm_service.dart';

class GeoJsonUtils {
  static String pathToGeoJson(List<Step> steps) {
    var path = steps.map((step) => step.node);
    final coordinates = path
        .map((node) => [node.longitude, node.latitude, node.altitude])
        .toList();

    final geoJson = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {"type": "LineString", "coordinates": coordinates},
          "properties": {
            "name": "route",
            "stroke": "#0084ff",
            "stroke-width": 5,
            "stroke-opacity": 1
          }
        }
      ]
    };

    return jsonEncode(geoJson);
  }
}
