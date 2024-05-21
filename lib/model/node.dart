import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/piste_type_enum.dart';
import 'package:routing_service/model/neighbor.dart';

class Node {
  final double latitude;
  final double longitude;
  final double? altitude;
  final NodeType nodeType;
  final RunType runType;
  final List<Neighbor> neighbors;

  Node({
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.nodeType,
    required this.runType,
    List<Neighbor>? neighbors,
  }) : neighbors = neighbors ?? [];

  void addNeighbor(Node neighbor, double distance) {
    neighbors.add(Neighbor(node: neighbor, distance: distance));
  }
}
