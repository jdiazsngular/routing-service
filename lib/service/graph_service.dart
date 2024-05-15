import 'dart:convert';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/utils/math_utils.dart';

class GraphService {
  static const double tolerance = 0.0001;

  static Graph geoJsonToGraph(String geoJsonString) {
    final graph = Graph();

    // Decodificar el string geoJson a un mapa
    final Map<String, dynamic> geoJson = jsonDecode(geoJsonString);
    final features = geoJson['features'] as List<dynamic>;

    // Iterar sobre cada feature en el geoJson
    for (var feature in features) {
      final geometry = feature['geometry'];

      // Verificar si el tipo de geometría es LineString
      if (geometry['type'] == 'LineString') {
        final coordinates = geometry['coordinates'] as List<dynamic>;

        // Iterar sobre las coordenadas y crear nodos y vecinos
        // Iteramos sobre cada par consecutivo de coordenadas.
        //Es decir, para cada par de coordenadas (start, end),
        //creamos nodos y establecemos conexiones entre ellos.
        for (var i = 0; i < coordinates.length - 1; i++) {
          final startCoord = coordinates[i];
          final endCoord = coordinates[i + 1];

          // Agregar nodos al grafo y convertir las coordenadas a double
          final startNode = graph.addNode(
            startCoord[1].toDouble(),
            startCoord[0].toDouble(),
            startCoord[2].toDouble(),
          );
          final endNode = graph.addNode(
            endCoord[1].toDouble(),
            endCoord[0].toDouble(),
            endCoord[2].toDouble(),
          );

          // Calcular la distancia entre los nodos
          final distance =
              MathUtil.calculateDistanceByHaversine(startNode, endNode);

          // Agregar vecinos a los nodos
          graph.addNeighbor(startNode, endNode, distance);
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
            node1.longitude == node2.longitude &&
            node1.altitude == node2.altitude) {
          final distance = MathUtil.calculateDistanceByHaversine(node1, node2);

          graph.addNeighbor(node1, node2, distance);
          graph.addNeighbor(node2, node1, distance);
        }
      }
    }

    return graph;
  }
}
