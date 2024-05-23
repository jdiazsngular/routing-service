import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/neighbor.dart';

class Node {
  final double latitude;
  final double longitude;
  final double? altitude;
  final NodeType nodeType;
  final List<Neighbor> neighbors;

  Node({
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.nodeType,
    List<Neighbor>? neighbors,
  }) : neighbors = neighbors ?? [];

  void addNeighbor(Node neighbor, double distance, RunType runType, String name) {
    neighbors.add(Neighbor(node: neighbor, distance: distance, runType: runType, name: name));
  }
}
