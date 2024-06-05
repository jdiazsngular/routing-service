import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/utils/math_utils.dart';

class Graph {
  final Map<String, Node> nodes = {};

  String _getNodeKey(double lat, double long, [double? alt]) {
    return '$lat,$long,${alt ?? ''}';
  }

  Node addNode(double lat, double long, double? alt, NodeType nodeType) {
    final key = _getNodeKey(lat, long, alt);
    if (!nodes.containsKey(key)) {
      nodes[key] = Node(latitude: lat, longitude: long, altitude: alt, nodeType: nodeType);
    }
    return nodes[key]!;
  }

  void assignNeighbor(Node node1, Node node2, double distance, double weight, RunType runType, String name, int direction) {
    node1.addNeighbor(node2, distance, weight, runType, name, direction);
  }

  Node findClosestNode(double lat, double lon, double alt) {
    Node? closestNode;
    double minDistance = double.infinity;

    for (var node in nodes.values) {
      final distance = MathUtil.calculateDistanceByHaversineWithCoordinates(lat, lon, node.latitude, node.longitude);

      if (distance < minDistance) {
        minDistance = distance;
        closestNode = node;
      }
    }

    return closestNode!;
  }

  void penalizeNeightborFor(Node node, Node nextNode, UserOption userOption) {
    double penalizationFactor = 1.25;
    if (node.nodeType == NodeType.run && nextNode.nodeType != NodeType.lift) {
      Node? graphNode = nodes[node.getKey()];
      if (graphNode == null) return;
      for (var neighbor in graphNode.neighbors) {
        if (neighbor.node.getKey() == nextNode.getKey()) {
          neighbor.weight = neighbor.weight * penalizationFactor;
        }
      }
    }
  }
}
