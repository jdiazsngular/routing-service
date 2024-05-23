import 'package:collection/collection.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';

/// Dijkstra Algorithm: Encuentra la ruta más corta desde un nodo origen a un nodo destino
class RouteAlgorithmService {
  static List<Node> findShortestPath(
      Graph graph, Node startNode, Node endNode) {
    final distances = <Node, double>{};
    final path = <Node, Node?>{};
    final priorityQueue =
        PriorityQueue<Node>((a, b) => distances[a]!.compareTo(distances[b]!));

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
          path[neighbor.node] = currentNode;

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

  static void _initializeDistancesAndPath(
      Graph graph, Map<Node, double> distances, Map<Node, Node?> path) {
    for (var node in graph.nodes.values) {
      distances[node] = double.infinity;
      path[node] = null;
    }
  }

  static List<Node> _constructRoute(Map<Node, Node?> path, Node endNode) {
    final route = <Node>[];
    Node? currentNode = endNode;

    while (currentNode != null) {
      route.add(currentNode);
      currentNode = path[currentNode];
    }

    return route.reversed.toList();
  }
}
