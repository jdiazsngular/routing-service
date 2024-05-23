import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/neighbor.dart';

class Node {
  final double latitude;
  final double longitude;
  final double? altitude;
  final NodeType nodeType;
  final List<RunType> runTypes;
  final List<String> names;
  final List<Neighbor> neighbors;

  Node({
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.nodeType,
    List<RunType>? runTypes,
    List<String>? names,
    List<Neighbor>? neighbors,
  })  : runTypes = runTypes ?? [],
        names = names ?? [],
        neighbors = neighbors ?? [];

  void addNeighbor(Node neighbor, double distance) {
    neighbors.add(Neighbor(node: neighbor, distance: distance));
  }

  void addName(String name) {
    names.add(name);
  }

  void addRunType(RunType runType) {
    runTypes.add(runType);
  }
}
