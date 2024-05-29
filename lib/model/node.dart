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

  String getKey() {
    return '$latitude,$longitude,${altitude ?? ''}';
  }

  void addNeighbor(Node neighbor, double distance, double weight, RunType runType, String name) {
    neighbors.add(Neighbor(node: neighbor, distance: distance, weight: weight, runType: runType, name: name));
  }

  @override
  String toString() {
    return "[$latitude, $longitude, $altitude]";
  }
}
