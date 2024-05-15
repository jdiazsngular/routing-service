/* import 'package:routing_service/node.dart';

class AStarAlgorithm {
  List<List<Node>> calculateRoute(
      List<List<Node>> graph, Node start, Node end) {
    final List<Node> openList = [];
    final List<Node> closedList = [];

    openList.add(start);
    start.g = 0;
    start.h = _calculateHeuristic(start, end);
    start.f = start.h;

    while (openList.isNotEmpty) {
      final Node currentNode = _getBest(openList);

      openList.remove(currentNode);
      closedList.add(currentNode);

      if (currentNode.latitude == end.latitude &&
          currentNode.longitude == end.longitude) {
        return _buildPath(currentNode);
      }

      final List<Node> neighbors = getNeighbors(graph, currentNode);

      for (final Node neighbor in neighbors) {
        if (closedList.contains(neighbor) || neighbor.isWall) {
          continue;
        }

        final double tempG = currentNode.g + 1;
        bool newPath = false;

        if (!openList.contains(neighbor)) {
          openList.add(neighbor);
          newPath = true;
        } else if (tempG < neighbor.g) {
          newPath = true;
        }

        if (newPath) {
          neighbor
            ..previous = currentNode
            ..g = tempG
            ..h = _calculateHeuristic(neighbor, end)
            ..f = tempG + neighbor.h;
        }
      }
    }

    return [];
  }

  double _calculateHeuristic(Node node, Node end) =>
      (node.latitude - end.latitude).abs() +
      (node.longitude - end.longitude).abs();

  Node _getBest(final List<Node> openList) {
    Node best = openList[0];

    for (final Node node in openList) {
      if (node.f < best.f) {
        best = node;
      }
    }

    return best;
  }

  List<List<Node>> _buildPath(Node endNode) {
    List<Node> path = [];
    Node currentNode = endNode;

    while (currentNode.previous != null) {
      path.add(currentNode);
      currentNode = currentNode.previous!;
    }

    path = path.reversed.toList();

    return [path];
  }

  List<Node> getNeighbors(List<List<Node>> graph, Node node) {
    List<Node> neighbors = [];
    int row = -1;
    int col = -1;

    for (int i = 0; i < graph.length; i++) {
      for (int j = 0; j < graph[i].length; j++) {
        if (graph[i][j].latitude == node.latitude &&
            graph[i][j].longitude == node.longitude) {
          row = i;
          col = j;
          break;
        }
      }
      if (row != -1) {
        break;
      }
    }

    if (row != -1 && col != -1) {
      if (row > 0) neighbors.add(graph[row - 1][col]); // Upper neighbor
      if (row < graph.length - 1) {
        neighbors.add(graph[row + 1][col]); // Lower neighbor
      }
      if (col > 0) neighbors.add(graph[row][col - 1]); // Left neighbor
      if (col < graph[0].length - 1) {
        neighbors.add(graph[row][col + 1]); // Right neighbor
      }
    }

    return neighbors;
  }
}
 */