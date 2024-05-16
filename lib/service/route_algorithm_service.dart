import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';

// Dijkstra Algorithm -- Encuentra la ruta más corta desde un nodo origen a un nodo destino

class RouteAlgorithmService {
  static List<Node> findShortestPath(Graph graph, Node start, Node end) {
    final distances = <Node, double>{};
    final previousNodes = <Node, Node?>{};
    final priorityQueue =
        PriorityQueue<Node>((a, b) => distances[a]!.compareTo(distances[b]!));

    for (var node in graph.nodes.values) {
      distances[node] = double.infinity;
      previousNodes[node] = null;
    }

    distances[start] = 0.0;
    priorityQueue.add(start);

    while (!priorityQueue.isEmpty) {
      final currentNode = priorityQueue.removeFirst();

      if (currentNode == end) {
        break;
      }

      for (var neighbor in currentNode.neighbors) {
        final distance = distances[currentNode]! + neighbor.distance;

        if (distance < distances[neighbor.node]!) {
          distances[neighbor.node] = distance;
          previousNodes[neighbor.node] = currentNode;

          if (!priorityQueue.contains(neighbor.node)) {
            priorityQueue.add(neighbor.node);
          }
        }
      }
    }

    return _constructPath(previousNodes, end);
  }

  static List<Node> _constructPath(Map<Node, Node?> previousNodes, Node end) {
    final path = <Node>[];
    Node? currentNode = end;

    while (currentNode != null) {
      path.add(currentNode);
      currentNode = previousNodes[currentNode];
    }

    return path.reversed.toList();
  }
}

class PriorityQueue<E> {
  final _list = <E>[];
  final int Function(E, E) _comparator;

  PriorityQueue(this._comparator);

  void add(E element) {
    _list.add(element);
    _list.sort(_comparator);
  }

  E removeFirst() {
    return _list.removeAt(0);
  }

  bool contains(E element) {
    return _list.contains(element);
  }

  bool get isEmpty => _list.isEmpty;
}
