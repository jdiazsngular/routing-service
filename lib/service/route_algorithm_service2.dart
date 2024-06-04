import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/step.dart';
import 'package:routing_service/model/user_option.dart';

class RouteAlgorithmService2 {
  
  List<Step> findRoute(Graph graph, Node startNode, Node endNode, UserOption userOption) {
    List<Step> result = [];

    var shortestPathToHighestNode = _findShortestPath(graph, startNode);
    if (shortestPathToHighestNode.isEmpty) {
      return result;
    }

    Node highestNode = shortestPathToHighestNode.last.node;

    var longestDescentPath = _findLongestPath(graph, highestNode, endNode);

    result.addAll(shortestPathToHighestNode);
    result.addAll(longestDescentPath);

    return result;
  }

  // Encuentra el camino más corto desde el origen al nodo más alto alcanzable usando Dijkstra.
  List<Step> _findShortestPath(Graph graph, Node startNode) {
    return [];
  }

  // Encuentra el descenso más largo desde el nodo más alto al destino usando DFS.
  List<Step> _findLongestPath(Graph graph, Node startNode, Node endNode) {
    return [];
  }
}
