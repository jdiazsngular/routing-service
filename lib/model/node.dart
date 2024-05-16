import 'package:routing_service/model/neighbor.dart';

class Node {
  final double latitude;
  final double longitude;
  final double? altitude;
  final bool isLift;
  final List<Neighbor> neighbors;

  Node({
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.isLift,
    List<Neighbor>? neighbors,
  }) : neighbors = neighbors ?? [];

  void addNeighbor(Node neighbor, double distance) {
    neighbors.add(Neighbor(node: neighbor, distance: distance));
  }
}
