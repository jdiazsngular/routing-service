import 'dart:convert';

import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/utils/math_utils.dart';

class GraphService {
  static Graph geoJsonToGraph(String geoJsonString, UserOption userOption) {
    final graph = Graph();

    final Map<String, dynamic> geoJson = jsonDecode(geoJsonString);
    final features = geoJson['features'] as List<dynamic>;

    for (var feature in features) {
      _buildNodesAndNeighbor(feature: feature, graph: graph, userOption: userOption);
    }

    return graph;
  }

  static void _buildNodesAndNeighbor({required dynamic feature, required Graph graph, required UserOption userOption, bool unidirectional = false }) {
    final geometry = feature['geometry'];
    final properties = feature['properties'];

    if (geometry['type'] != 'LineString') return;

    final coordinates = geometry['coordinates'] as List<dynamic>;
    NodeType nodeType = NodeTypeMapper.map(properties['type']);
    RunType runType = RunTypeMapper.map(properties['difficulty']);
    String name = properties['name'] ?? '';

    for (var i = 0; i < coordinates.length - 1; i++) {
      final currentCoord = coordinates[i];
      final nextCoord = coordinates[i + 1];

      final Node currentNode = _createNode(graph, name, currentCoord, nodeType);
      final Node nextNode = _createNode(graph, name, nextCoord, nodeType);

      final distance = MathUtil.calculateDistanceByHaversine(currentNode, nextNode);
      int direction = 1;
      if (nodeType == NodeType.connection || nodeType == NodeType.unknown) direction = 0;

      final currentToNextWeight =
          distance + MathUtil.calculateFactorFor(currentNode, nextNode, runType, userOption, distance, direction);
      graph.assignNeighbor(currentNode, nextNode, distance, currentToNextWeight, runType, name);

      if (unidirectional) continue;
      final nextToCurrentWeight = distance + MathUtil.calculateFactorFor(nextNode, currentNode, runType, userOption, distance, -direction);
      graph.assignNeighbor(nextNode, currentNode, distance, nextToCurrentWeight, runType, name);
    }
  }

  static Node _createNode(Graph graph, String name, currentCoord, NodeType nodeType) {
    final currentNode = graph.addNode(
        currentCoord[1].toDouble(), currentCoord[0].toDouble(), _getOptionalRange(currentCoord, 2), nodeType);
    return currentNode;
  }

  static double? _getOptionalRange(List<dynamic> coord, int position) {
    if (coord.length > position) {
      return coord[2].toDouble();
    }
    return null;
  }
}
