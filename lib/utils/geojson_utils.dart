import 'dart:convert';

import 'package:routing_service/model/step.dart';

class GeoJsonUtils {
  static const Map<ColorEnum, String> colors = {
    ColorEnum.blue: '#0084ff',
    ColorEnum.green: '#00ff00',
    ColorEnum.red: '#ff0000',
    ColorEnum.purple: '#800080',
    ColorEnum.yellow: '#ffff00',
  };

  static String pathToGeoJsonFeature(List<Step> steps, [ColorEnum? color]) {
    ColorEnum selectedColor = color ?? ColorEnum.blue;
    var path = steps.map((step) => step.node);
    final coordinates = path.map((node) => [node.longitude, node.latitude, node.altitude]).toList();

    final geoJson = {
      "type": "Feature",
      "geometry": {"type": "LineString", "coordinates": coordinates},
      "properties": {"name": "route", "stroke": colors[selectedColor], "stroke-width": 5, "stroke-opacity": 1}
    };

    return jsonEncode(geoJson);
  }
}

enum ColorEnum {
  red,
  green,
  blue,
  purple,
  yellow,
}
