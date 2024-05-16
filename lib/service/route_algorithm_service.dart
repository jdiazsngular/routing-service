import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';

// Dijkstra Algorithm -- Encuentra la ruta más corta desde un nodo origen a un nodo destino
class RouteAlgorithmService {
  static List<Node> findShortestPath(Graph graph, Node start, Node end) {
    final distances = <Node, double>{};
    final previousNodes = <Node, Node?>{};

    // Cola de prioridad para procesar los nodos en orden de distancia más corta
    final priorityQueue =
        PriorityQueue<Node>((a, b) => distances[a]!.compareTo(distances[b]!));

    // Inicializa las distancias a infinito y los nodos previos a null
    for (var node in graph.nodes.values) {
      distances[node] = double.infinity;
      previousNodes[node] = null;
    }

    // La distancia al nodo de inicio es 0
    distances[start] = 0.0;
    priorityQueue.add(start);

    // Procesa la cola de prioridad hasta que esté vacía
    while (!priorityQueue.isEmpty) {
      final currentNode = priorityQueue.removeFirst();

      // Si el nodo actual es el nodo de destino, termina el bucle
      if (currentNode == end) {
        break;
      }

      // Actualiza las distancias a los nodos vecinos
      for (var neighbor in currentNode.neighbors) {
        final distance = distances[currentNode]! + neighbor.distance;

        // Si se encuentra una distancia más corta, se actualiza
        if (distance < distances[neighbor.node]!) {
          distances[neighbor.node] = distance;
          previousNodes[neighbor.node] = currentNode;

          // Si el nodo vecino no está en la cola de prioridad, se agrega
          if (!priorityQueue.contains(neighbor.node)) {
            priorityQueue.add(neighbor.node);
          }
        }
      }
    }

    // retorna el camino más corto desde el nodo de inicio al de destino
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

// Clase PriorityQueue para manejar la cola de prioridad en el algoritmo de Dijkstra
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
