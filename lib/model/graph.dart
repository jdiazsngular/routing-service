import 'package:routing_service/model/node.dart';

class Graph {
  final Map<String, Node> nodes = {};

  String _getNodeKey(double lat, double long, double alt) {
    return '$lat,$long,$alt';
  }

  Node addNode(double lat, double long, double alt) {
    final key = _getNodeKey(lat, long, alt);
    if (!nodes.containsKey(key)) {
      nodes[key] = Node(latitude: lat, longitude: long, altitude: alt);
    }
    return nodes[key]!;
  }

  void addNeighbor(Node node1, Node node2, double distance) {
    node1.addNeighbor(node2, distance);
  }
}
