import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/node.dart';

class Step {
  Node node;
  double distance;
  double weight;
  RunType runType;

  Step({required this.node, required this.distance, required this.weight, required this.runType});
}
