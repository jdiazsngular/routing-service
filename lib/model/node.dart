import 'package:routing_service/model/neighbor.dart';

class Node {
  final double latitude;
  final double longitude;
  final double? altitude;
  final List<Neighbor> neighbors;

  Node({
    required this.latitude,
    required this.longitude,
    this.altitude,
    List<Neighbor>? neighbors,
  }) : neighbors = neighbors ?? [];

  void addNeighbor(Node neighbor, double distance) {
    neighbors.add(Neighbor(node: neighbor, distance: distance));
  }
}
