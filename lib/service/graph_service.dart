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
      _buildNodesAndNeighbor(feature, graph, userOption);
    }

    return graph;
  }

  static Graph geoJsonToGraphUnidirectional(String geoJsonString, UserOption userOption) {
    final graph = Graph();

    final Map<String, dynamic> geoJson = jsonDecode(geoJsonString);
    final features = geoJson['features'] as List<dynamic>;

    for (var feature in features) {
      _buildNodesAndNeighborUnidirectional(feature, graph, userOption);
    }

    return graph;
  }

  static void _buildNodesAndNeighbor(dynamic feature, Graph graph, UserOption userOption) {
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

      final currentToNextWeight = distance + MathUtil.calculateFactorFor(currentNode, nextNode, runType, userOption);
      final nextToCurrentWeight = distance + MathUtil.calculateFactorFor(nextNode, currentNode, runType, userOption);

      graph.assignNeighbor(currentNode, nextNode, distance, currentToNextWeight, runType, name);
      graph.assignNeighbor(nextNode, currentNode, distance, nextToCurrentWeight, runType, name);
    }
  }

  static void _buildNodesAndNeighborUnidirectional(dynamic feature, Graph graph, UserOption userOption) {
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

      final currentToNextWeight = distance + MathUtil.calculateFactorFor(currentNode, nextNode, runType, userOption);

      graph.assignNeighbor(currentNode, nextNode, distance, currentToNextWeight, runType, name);
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
