/* import 'package:routing_service/a_start_algorithm.dart';
import 'package:routing_service/file_service.dart';
import 'package:routing_service/graph_service.dart';
import 'package:routing_service/node.dart';

AStarAlgorithm aStarAlgorithm = AStarAlgorithm();

Future<List<List<Node>>> calculateGraph(String geoJson) async {
  String jsonString = await FileService.loadFile(geoJson);
  return GraphService.geoJsonToGraph(jsonString);
}

// String calculateRoute(List<List<Node>> graph, startLatitude, startLongitude, endLatitude, endLongitude) async {
//  List<List<Node>> nodes =
//      aStarAlgorithm.calculateRoute(graph, startNode, endNode);
//  return convertGeoJson(nodes);
// }

void calculateRoute() async {
  List<List<Node>> graph =
      await calculateGraph('assets/Converted_Cerler.geojson');

  Node startNode = Node(42.586981900000005, 0.5402348);
  Node endNode = Node(42.579162200000006, 0.5408676);

  List<List<Node>> nodes =
      aStarAlgorithm.calculateRoute(graph, startNode, endNode);

  print("camino");
  for (int i = 0; i < nodes.length; i++) {
    for (int j = 0; j < nodes[i].length; j++) {
      print("-----------------------------");
      print(nodes[i][j].latitude);
      print(nodes[i][j].longitude);
      print("-----------------------------");
    }
  }
}
 */