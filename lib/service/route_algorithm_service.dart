import 'package:collection/collection.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';

class RouteAlgorithmService {
  static List<Step> findShortestPath(Graph graph, Node startNode, Node endNode) {
    final weights = <Node, double>{};
    final path = <Node, Step?>{};
    final priorityQueue = PriorityQueue<Node>((a, b) => weights[a]!.compareTo(weights[b]!));

    _initializeDistancesAndPath(graph, weights, path);

    weights[startNode] = 0.0;
    priorityQueue.add(startNode);

    while (priorityQueue.isNotEmpty) {
      final currentNode = priorityQueue.removeFirst();

      if (currentNode == endNode) {
        break;
      }

      for (var neighbor in currentNode.neighbors) {
        final weight = weights[currentNode]! + neighbor.weight;

        if (weight < weights[neighbor.node]!) {
          weights[neighbor.node] = weight;
          path[neighbor.node] = Step(node: currentNode, runType: neighbor.runType);

          if (!priorityQueue.contains(neighbor.node)) {
            priorityQueue.add(neighbor.node);
          }
        }
      }
    }

    if (weights[endNode] == double.infinity) {
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
    Step? currentStep = Step(node: endNode, runType: path[endNode]!.runType);

    while (currentStep != null) {
      route.add(currentStep);
      currentStep = path[currentStep.node];
    }

    return route.reversed.toList();
  }

  static List<List<Step>> findKShortestPaths(Graph graph, Node startNode, Node endNode, int K, UserOption userOption) {
    List<List<Step>> kShortestPaths = [];

    List<Step> initialShortestPath = findShortestPath(graph, startNode, endNode);
    kShortestPaths.add(initialShortestPath);

    for (int k = 1; k < K; k++) {
      var currentkShortestPath = kShortestPaths[k - 1];

      for (int i = 0; i < currentkShortestPath.length - 1; i++) {
        Node node = currentkShortestPath[i].node;
        Node nextNode = currentkShortestPath[i + 1].node;
        graph.penalizeNeightborFor(node, nextNode, userOption);
      }
      List<Step> alternatePath = findShortestPath(graph, startNode, endNode);
      kShortestPaths.add(alternatePath);
    }

    return kShortestPaths;
  }
}

class Step {
  Node node;
  RunType runType;

  Step({required this.node, required this.runType});

  @override
  String toString() {
    return "{${node.toString()}, runType: $runType}";
  }
}
