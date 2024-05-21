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

void calculateRoute(List<double> startCoordinate, List<double> endCoordinate) async {
  Stopwatch stopwatch = Stopwatch();

  stopwatch.start();
  Graph graph = await calculateGraph('assets/filtered_lifts.geojson');
  stopwatch.stop();
  print('Calculate graph time: ${stopwatch.elapsedMilliseconds} ms');
  
  stopwatch.reset();
  stopwatch.start();
  Node startNode = graph.findClosestNode(startCoordinate[0], startCoordinate[1], startCoordinate[2]);
  Node endNode = graph.findClosestNode(endCoordinate[0], endCoordinate[1], endCoordinate[2]);

  final shortestPath =
      RouteAlgorithmService.findShortestPath(graph, startNode, endNode);
  stopwatch.stop();
  print('Calculate route time: ${stopwatch.elapsedMilliseconds} ms');
  
  final geoJson = GeoJsonUtils.pathToGeoJson(shortestPath);
  print('GeoJSON:');
  print(geoJson);
}
