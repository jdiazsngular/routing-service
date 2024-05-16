import 'dart:convert';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/utils/geojson_utils.dart';
import 'package:routing_service/utils/math_utils.dart';

class GraphService {
  static Graph geoJsonToGraph(String geoJsonString) {
    final graph = Graph();

    // Decodificar el string geoJson a un mapa
    final Map<String, dynamic> geoJson = jsonDecode(geoJsonString);
    final features = geoJson['features'] as List<dynamic>;

    // Iterar sobre cada feature en el geoJson
    for (var feature in features) {
      final geometry = feature['geometry'];
      final properties = feature['properties'];

      // Verificar si la feature es un telesilla
      PisteType pisteType = GeoJsonUtils.mapGeoJsonToPisteType(properties['type']);

      // Verificar si el tipo de geometría es LineString
      if (geometry['type'] == 'LineString') {
        final coordinates = geometry['coordinates'] as List<dynamic>;

        // Iterar sobre las coordenadas y crear nodos y vecinos
        for (var i = 0; i < coordinates.length - 1; i++) {
          final currentCoord = coordinates[i];
          final nextCoord = coordinates[i + 1];

          // Agregar nodos al grafo y convertir las coordenadas a double
          final currentNode = graph.addNode(
            currentCoord[1].toDouble(),
            currentCoord[0].toDouble(),
            _getOptionalRange(currentCoord, 2),
            pisteType);

          final nextNode = graph.addNode(
            nextCoord[1].toDouble(),
            nextCoord[0].toDouble(), 
            _getOptionalRange(nextCoord, 2),
            pisteType);

          // Calcular la distancia entre los nodos
          final distance =
              MathUtil.calculateDistanceByHaversine(currentNode, nextNode);

          // Agregar vecinos a los nodos
          graph.addNeighbor(currentNode, nextNode, distance);
          graph.addNeighbor(nextNode, currentNode, distance);
        }
      }
    }

    return graph;
  }

  static double? _getOptionalRange(List<dynamic> coord, int position) {
    if (coord.length > position) {
      return coord[2].toDouble();
    }
    return null;
  }
}
