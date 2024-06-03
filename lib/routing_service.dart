import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/graph.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/service/file_service.dart';
import 'package:routing_service/service/graph_service.dart';
import 'package:routing_service/service/route_algorithm_service.dart';
import 'package:routing_service/utils/geojson_utils.dart';

Future<Graph> calculateGraph(String geoJson, UserOption userOption) async {
  String jsonString = await FileService.loadFile(geoJson);
  return GraphService.geoJsonToGraph(jsonString, userOption);
}

Future<Graph> calculateGraphUnidirectional(String geoJson, UserOption userOption) async {
  String jsonString = await FileService.loadFile(geoJson);
  return GraphService.geoJsonToGraphUnidirectional(jsonString, userOption);
}

Future<String> calculateRoute(UserOption userOption, List<double> startCoordinate, List<double> endCoordinate) async {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  Graph graph = await calculateGraph('assets/filtered_lifts.geojson', userOption);

  stopwatch.stop();
  print('Calculate graph time: ${stopwatch.elapsedMilliseconds} ms');

  stopwatch.reset();
  stopwatch.start();
  Node startNode = graph.findClosestNode(startCoordinate[0], startCoordinate[1], startCoordinate[2]);
  Node endNode = graph.findClosestNode(endCoordinate[0], endCoordinate[1], endCoordinate[2]);

  final shortestPath = RouteAlgorithmService.findShortestPath(graph, startNode, endNode);
  stopwatch.stop();
  print('Calculate route time: ${stopwatch.elapsedMilliseconds} ms');

  final geoJson = GeoJsonUtils.pathToGeoJsonFeature(shortestPath);
  print('-------------------- geojson ---------------------');
  print(geoJson);

  return geoJson;
}

Future<List<Step>> calculateRouteSteps(
    UserOption userOption, List<double> startCoordinate, List<double> endCoordinate) async {
  Graph graph = await calculateGraph('assets/filtered_lifts.geojson', userOption);

  Node startNode = graph.findClosestNode(startCoordinate[0], startCoordinate[1], startCoordinate[2]);
  Node endNode = graph.findClosestNode(endCoordinate[0], endCoordinate[1], endCoordinate[2]);

  return RouteAlgorithmService.findShortestPath(graph, startNode, endNode);
}

Future<List<Step>> calculateLongestRoute(
    UserOption userOption, List<double> startCoordinate, List<double> endCoordinate) async {
  Graph graph = await calculateGraphUnidirectional('assets/filtered_lifts.geojson', userOption);

  Node startNode = graph.findClosestNode(startCoordinate[0], startCoordinate[1], startCoordinate[2]);
  Node endNode = graph.findClosestNode(endCoordinate[0], endCoordinate[1], endCoordinate[2]);

  return RouteAlgorithmService.findLongestDownhillPath(graph, startNode, endNode);
}

Future<List<List<Step>>> calculateAlternateRoute(
    UserOption userOption, List<double> startCoordinate, List<double> endCoordinate, int numberOfPaths) async {
  Graph graph = await calculateGraph('assets/filtered_lifts.geojson', userOption);

  Node startNode = graph.findClosestNode(startCoordinate[0], startCoordinate[1], startCoordinate[2]);
  Node endNode = graph.findClosestNode(endCoordinate[0], endCoordinate[1], endCoordinate[2]);

  return RouteAlgorithmService.findKShortestPaths(graph, startNode, endNode, numberOfPaths, userOption);
}

List<Step> getInvalidRunSteps(List<Step> steps, RunType userLevel) {
  return steps.where((step) => step.node.nodeType == NodeType.run && step.runType.index > userLevel.index).toList();
}
