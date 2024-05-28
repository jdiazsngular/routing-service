import 'package:collection/collection.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/neighbor.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/utils/math_utils.dart';

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
    Step? currentStep = Step(node: endNode, runType: path[endNode]!.runType);

    while (currentStep != null) {
      route.add(currentStep);
      currentStep = path[currentStep.node];
    }

    return route.reversed.toList();
  }

  static List<List<Step>> findKShortestPaths(Graph graph, Node startNode, Node endNode, int K) {
    List<List<Step>> kShortestPaths = [];

    // Encuentra el camino más corto inicial
    List<Step> initialShortestPath = findShortestPath(graph, startNode, endNode);
    kShortestPaths.add(initialShortestPath);

    PriorityQueue<List<Step>> potentialPaths = PriorityQueue<List<Step>>((a, b) {
      return _calculatePathDistance(a).compareTo(_calculatePathDistance(b));
    });

    for (int k = 1; k < K; k++) {
      for (int i = 0; i < kShortestPaths[k - 1].length - 1; i++) {
        Node spurNode = kShortestPaths[k - 1][i].node;
        List<Step> rootPath = kShortestPaths[k - 1].sublist(0, i + 1);

        List<List<Neighbor>> removedEdges = [];
        for (List<Step> path in kShortestPaths) {
          if (_isSameRootPath(rootPath, path, i + 1)) {
            Node u = path[i].node;
            Node v = path[i + 1].node;
            var removedEdge = graph.removeEdge(u, v);
            if (removedEdge.length == 2) removedEdges.add(removedEdge);
          }
        }

        try {
          List<Step> spurPath = findShortestPath(graph, spurNode, endNode);
          List<Step> totalPath = List<Step>.from(rootPath)..addAll(spurPath);
          potentialPaths.add(totalPath);
        } catch (e) {
          // No valid spur path, continue
        }

        for (var edges in removedEdges) {
          graph.addEdge(edges.first, edges.last);
        }
      }

      kShortestPaths.add(potentialPaths.removeFirst());
    }

    return kShortestPaths;
  }

  static double _calculatePathDistance(List<Step> path) {
    double totalDistance = 0.0;
    for (var i = 0; i < path.length - 1; i++) {
      var currentNode = path.elementAt(i).node;
      var nextNode = path.elementAt(i+1).node;
      var currentNeightbor = currentNode.neighbors.firstWhereOrNull((element) => element.node == nextNode);
      var distance = 0.0;
      if (currentNeightbor != null) {
        distance = currentNeightbor.distance;
      } else {
        distance = MathUtil.calculateDistanceByHaversine(currentNode, nextNode);
      }
      totalDistance += distance;
    }
    return totalDistance;
  }

  static bool _isSameRootPath(List<Step> rootPath, List<Step> path, int length) {
    if (rootPath.length != length) return false;
    for (int i = 0; i < length; i++) {
      if (rootPath[i].node != path[i].node) {
        return false;
      }
    }
    return true;
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
