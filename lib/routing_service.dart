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
  Stopwatch stopwatch = Stopwatch();

  stopwatch.start();
  Graph graph = await calculateGraph('assets/filtered_lifts.geojson');
  stopwatch.stop();
  print('Calculate graph time: ${stopwatch.elapsedMilliseconds} ms');
  
  stopwatch.reset();
  stopwatch.start();
  Node startNode = graph.findClosestNode(42.586867299999994, 0.5400737, 1506.83);
  Node endNode = graph.findClosestNode(42.5441, 0.5556, 2147.29);

  final shortestPath =
      RouteAlgorithmService.findShortestPath(graph, startNode, endNode);
  stopwatch.stop();
  print('Calculate route time: ${stopwatch.elapsedMilliseconds} ms');
  
  final geoJson = GeoJsonUtils.pathToGeoJson(shortestPath);
  print('GeoJSON:');
  print(geoJson);
}
