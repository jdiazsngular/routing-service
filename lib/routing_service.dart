import 'package:routing_service/model/graph.dart';
import 'package:routing_service/service/file_service.dart';
import 'package:routing_service/service/graph_service.dart';
import 'package:routing_service/service/route_algorithm_service.dart';

Future<Graph> calculateGraph(String geoJson) async {
  String jsonString = await FileService.loadFile(geoJson);
  return GraphService.geoJsonToGraph(jsonString);
}

// String calculateRoute(List<List<Node>> graph, startLatitude, startLongitude, endLatitude, endLongitude) async {
//  List<List<Node>> nodes =
//      aStarAlgorithm.calculateRoute(graph, startNode, endNode);
//  return convertGeoJson(nodes);
// }

void calculateRoute() async {
  Graph graph = await calculateGraph('assets/filtered_lifts.geojson');

  final startNode = graph.nodes.values.elementAt(200);
  final endNode = graph.nodes.values.elementAt(555);

  final shortestPath = Dijkstra.findShortestPath(graph, startNode, endNode);

  print('Shortest Path:');
  for (var node in shortestPath) {
    print('(${node.latitude}, ${node.longitude}, ${node.altitude})');
  }
}
