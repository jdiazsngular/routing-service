import 'dart:convert';

import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/piste_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/utils/math_utils.dart';

class GraphService {
  static Graph geoJsonToGraph(String geoJsonString, RunType userLevel) {
    final graph = Graph();

    final Map<String, dynamic> geoJson = jsonDecode(geoJsonString);
    final features = geoJson['features'] as List<dynamic>;

    for (var feature in features) {
      _buildNodesAndNeighbor(feature, graph, userLevel);
    }

    return graph;
  }

  static void _buildNodesAndNeighbor(
      dynamic feature, Graph graph, RunType userLevel) {
    final geometry = feature['geometry'];
    final properties = feature['properties'];

    if (geometry['type'] != 'LineString') return;

    final coordinates = geometry['coordinates'] as List<dynamic>;
    NodeType nodeType = NodeTypeMapper.map(properties['type']);

    RunType runType = RunType.unknown;
    if (properties['difficulty'] != null) {
      runType = PisteTypeMapper.map(properties['difficulty']);
    }

    for (var i = 0; i < coordinates.length - 1; i++) {
      final currentCoord = coordinates[i];
      final nextCoord = coordinates[i + 1];

      final Node currentNode =
          _createNode(graph, currentCoord, nodeType, runType);
      final Node nextNode = _createNode(graph, nextCoord, nodeType, runType);

      final distance =
          MathUtil.calculateDistanceByHaversine(currentNode, nextNode);

      final currentToNextCost = distance +
          MathUtil.calculateFactorFor(
              currentNode, nextNode, runType, userLevel);
      final nextToCurrentCost = distance +
          MathUtil.calculateFactorFor(
              nextNode, currentNode, runType, userLevel);

      graph.addNeighbor(currentNode, nextNode, currentToNextCost);
      graph.addNeighbor(nextNode, currentNode, nextToCurrentCost);
    }
  }

  static Node _createNode(
      Graph graph, currentCoord, NodeType nodeType, RunType runType) {
    final currentNode = graph.addNode(
        currentCoord[1].toDouble(),
        currentCoord[0].toDouble(),
        _getOptionalRange(currentCoord, 2),
        nodeType,
        runType);
    return currentNode;
  }

  static double? _getOptionalRange(List<dynamic> coord, int position) {
    if (coord.length > position) {
      return coord[2].toDouble();
    }
    return null;
  }
}
