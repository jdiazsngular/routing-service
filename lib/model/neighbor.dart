import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/node.dart';

class Neighbor {
  final Node node;
  final double distance;
  double weight;
  final RunType runType;
  final String name;

  Neighbor({required this.node, required this.distance, required this.weight, required this.runType, required this.name});
}
