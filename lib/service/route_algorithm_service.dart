import 'package:collection/collection.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';

/// Dijkstra Algorithm: Encuentra la ruta más corta desde un nodo origen a un nodo destino
class RouteAlgorithmService {
  static List<Step> findShortestPath(Graph graph, Node startNode, Node endNode) {
    final distances = <Node, double>{};
    final path = <Node, Step?>{};
    final priorityQueue = PriorityQueue<Node>((a, b) => distances[a]!.compareTo(distances[b]!));

    _initializeDistancesAndPath(graph, distances, path);

    distances[startNode] = 0.0;
    priorityQueue.add(startNode);

    while (priorityQueue.isNotEmpty) {
      final currentNode = priorityQueue.removeFirst();

      if (currentNode == endNode) {
        break;
      }

      for (var neighbor in currentNode.neighbors) {
        final distance = distances[currentNode]! + neighbor.distance;

        if (distance < distances[neighbor.node]!) {
          distances[neighbor.node] = distance;
          path[neighbor.node] = Step(node: currentNode, runType: neighbor.runType);

          if (!priorityQueue.contains(neighbor.node)) {
            priorityQueue.add(neighbor.node);
          }
        }
      }
    }

    if (distances[endNode] == double.infinity) {
      throw Exception('No route available within the user\'s skill level');
    }

    return _constructRoute(path, endNode);
  }

  static void _initializeDistancesAndPath(Graph graph, Map<Node, double> distances, Map<Node, Step?> path) {
    for (var node in graph.nodes.values) {
      distances[node] = double.infinity;
      path[node] = null;
    }
  }

  static List<Step> _constructRoute(Map<Node, Step?> path, Node endNode) {
    final route = <Step>[];
    Step? currentStep = path[endNode];

    while (currentStep != null) {
      route.add(currentStep);
      currentStep = path[currentStep.node];
    }

    return route.reversed.toList();
  }
}

class Step {
  Node node;
  RunType runType;

  Step({required this.node, required this.runType});
}
