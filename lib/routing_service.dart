import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/service/file_service.dart';
import 'package:routing_service/service/graph_service.dart';
import 'package:routing_service/service/route_algorithm_service.dart';
import 'package:routing_service/utils/geojson_utils.dart';

Future<Graph> calculateGraph(String geoJson) async {
  String jsonString = await FileService.loadFile(geoJson);
  return GraphService.geoJsonToGraph(jsonString);
}

void calculateRoute() async {
  Graph graph = await calculateGraph('assets/filtered_lifts.geojson');

  Node startNode = graph.findClosestNode(42.586867299999994, 0.5400737, 1506.83);
  Node endNode = graph.findClosestNode(42.5441, 0.5556, 2147.29);

  final shortestPath =
      RouteAlgorithmService.findShortestPath(graph, startNode, endNode);
  print('Shortest Path:');
  for (var node in shortestPath) {
    print('(${node.latitude}, ${node.longitude}, ${node.altitude})');
  }

  final geoJson = GeoJsonUtils.pathToGeoJson(shortestPath);
  print('GeoJSON:');
  print(geoJson);
}
