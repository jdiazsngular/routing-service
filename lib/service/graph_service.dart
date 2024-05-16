import 'dart:convert';
import 'package:routing_service/model/graph.dart';
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
      bool isLift = properties['type'] != null &&
          properties['type'].toString().startsWith('lift');

      // Verificar si el tipo de geometría es LineString
      if (geometry['type'] == 'LineString') {
        final coordinates = geometry['coordinates'] as List<dynamic>;

        // Iterar sobre las coordenadas y crear nodos y vecinos
        for (var i = 0; i < coordinates.length - 1; i++) {
          final startCoord = coordinates[i];
          final endCoord = coordinates[i + 1];

          // Agregar nodos al grafo y convertir las coordenadas a double
          final startNode = graph.addNode(
              startCoord[1].toDouble(),
              startCoord[0].toDouble(),
              _getOptionalRange(startCoord, 2),
              isLift);

          final endNode = graph.addNode(endCoord[1].toDouble(),
              endCoord[0].toDouble(), _getOptionalRange(endCoord, 2), isLift);

          // Calcular la distancia entre los nodos
          final distance =
              MathUtil.calculateDistanceByHaversine(startNode, endNode);

          // Agregar vecinos a los nodos
          graph.addNeighbor(startNode, endNode, distance);
          graph.addNeighbor(endNode, startNode, distance);
        }
      }
    }

    // Conectar nodos entre LineStrings por coordenadas (lat, long, alt)
    // Agregar nodos vecinos bidireccionalmente
    final nodeKeys = graph.nodes.keys.toList();
    for (var i = 0; i < nodeKeys.length; i++) {
      final node1 = graph.nodes[nodeKeys[i]]!;
      for (var j = i + 1; j < nodeKeys.length; j++) {
        final node2 = graph.nodes[nodeKeys[j]]!;
        if (node1.latitude == node2.latitude &&
            node1.longitude == node2.longitude) {
          final distance = MathUtil.calculateDistanceByHaversine(node1, node2);

          graph.addNeighbor(node1, node2, distance);
          graph.addNeighbor(node2, node1, distance);
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
