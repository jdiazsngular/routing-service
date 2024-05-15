import 'package:routing_service/model/graph.dart';
import 'package:routing_service/service/file_service.dart';
import 'package:routing_service/service/graph_service.dart';

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
  Graph graph = await calculateGraph('assets/test.geojson');

  print(graph);
}
