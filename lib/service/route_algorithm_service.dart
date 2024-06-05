import 'package:collection/collection.dart';
import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/step.dart';
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
          path[neighbor.node] =
              Step(node: currentNode, distance: neighbor.distance, weight: neighbor.weight, runType: neighbor.runType);

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

  static List<List<Step>> findKShortestPaths(Graph graph, Node startNode, Node endNode, int K, UserOption userOption) {
    List<List<Step>> kShortestPaths = [];

    List<Step> initialShortestPath = findShortestPath(graph, startNode, endNode);
    kShortestPaths.add(initialShortestPath);

    for (int k = 1; k < K; k++) {
      var currentkShortestPath = kShortestPaths[k - 1];

      for (int i = 0; i < currentkShortestPath.length - 1; i++) {
        Node node = currentkShortestPath[i].node;
        Node nextNode = currentkShortestPath[i + 1].node;
        graph.penalizeNeightborFor(
          node,
          nextNode,
          userOption,
        );
      }
      List<Step> alternatePath = findShortestPath(graph, startNode, endNode);
      kShortestPaths.add(alternatePath);
    }

    return kShortestPaths;
  }

  static List<Step> findLongestPath(Graph graph, Node startNode, Node endNode, int K, UserOption userOption) {
    List<List<Step>> kShortestPaths = findKShortestPaths(graph, startNode, endNode, K, userOption);
    return _findLongestPath(kShortestPaths);
  }

  static List<Step> findLongestDownhillPath(Graph graph, Node startNode, Node endNode) {
    List<Step> result = [];

    var longestDescentPath = _findLongestDownhillPath(graph, endNode);
    if (longestDescentPath.isEmpty) {
      return result;
    }

    var shortestPathToHighestNode = findShortestPath(graph, startNode, longestDescentPath.last.node);

    result.addAll(shortestPathToHighestNode);
    result.addAll(longestDescentPath.reversed);

    return result;
  }

  static List<Step> _findLongestPath(List<List<Step>> paths) {
    return paths.reduce((longestPath, currentPath) {
      double longestDistance = longestPath.fold(0.0, (sum, step) => sum + step.distance);
      double currentDistance = currentPath.fold(0.0, (sum, step) => sum + step.distance);
      return currentDistance > longestDistance ? currentPath : longestPath;
    });
  }

  static void _initializeDistancesAndPath(Graph graph, Map<Node, double> distances, Map<Node, Step?> path) {
    for (var node in graph.nodes.values) {
      distances[node] = double.infinity;
      path[node] = null;
    }
  }

  static void _initializeWeightsToZeroAndPath(Graph graph, Map<Node, double> weights, Map<Node, Step?> path) {
    for (var node in graph.nodes.values) {
      weights[node] = 0.0;
      path[node] = null;
    }
  }

  static List<Step> _constructRoute(Map<Node, Step?> path, Node endNode) {
    final route = <Step>[];
    Step? currentStep = Step(
        node: endNode,
        distance: path[endNode]!.distance,
        weight: path[endNode]!.weight,
        runType: path[endNode]!.runType);

    while (currentStep != null) {
      route.add(currentStep);
      currentStep = path[currentStep.node];
    }

    return route.reversed.toList();
  }

  static List<Step> _findLongestDownhillPath(Graph graph, Node endNode) {
    final weights = <Node, double>{};
    final path = <Node, Step?>{};
    final priorityQueue = PriorityQueue<Node>((a, b) => weights[a]!.compareTo(weights[b]!));

    _initializeWeightsToZeroAndPath(graph, weights, path);

    weights[endNode] = 0.0;
    priorityQueue.add(endNode);

    while (priorityQueue.isNotEmpty) {
      final currentNode = priorityQueue.removeFirst();

      var onlyDownhill = currentNode.neighbors.where((element) {
        return (element.node.nodeType == NodeType.run && element.direction < 0);
      });
      for (var neighbor in onlyDownhill) {
        final weight = weights[currentNode]! + neighbor.weight;

        if (weight > weights[neighbor.node]!) {
          weights[neighbor.node] = weight;
          path[neighbor.node] =
              Step(node: currentNode, distance: neighbor.distance, weight: neighbor.weight, runType: neighbor.runType);

          if (!priorityQueue.contains(neighbor.node)) {
            priorityQueue.add(neighbor.node);
          }
        }
      }
    }
    var heaviestWeightNode = endNode;
    weights.forEach((node, weight) {
      if (weight > weights[heaviestWeightNode]!) heaviestWeightNode = node;
    });

    return _constructRoute(path, heaviestWeightNode);
  }
}
