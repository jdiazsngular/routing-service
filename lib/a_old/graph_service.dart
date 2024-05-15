/* import 'dart:convert';

import 'package:routing_service/node.dart';

class GraphService {
  static List<List<Node>> geoJsonToGraph(String geoJsonString) {
    final Map<String, dynamic> geoJson = jsonDecode(geoJsonString);

    final List<List<Node>> graph = [];

    if (geoJson['type'] == 'FeatureCollection' && geoJson['features'] != null) {
      final List features = geoJson['features'];
      for (var feature in features) {
        if (feature['geometry'] != null &&
            feature['geometry']['type'] == 'LineString' &&
            feature['geometry']['coordinates'] != null) {
          final List coordinates = feature['geometry']['coordinates'];
          List<Node> pathNodes = [];

          for (var coordinate in coordinates) {
            double latitude = coordinate[1];
            double longitude = coordinate[0];
            Node node = Node(latitude, longitude);
            pathNodes.add(node);
          }
          graph.add(pathNodes);
        }
      }
    }

    return graph;
  }
}
 */