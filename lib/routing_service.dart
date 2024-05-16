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

  /*
    Punto de Inicio (Base de la Estación):
    Latitud: 42.5693
    Longitud: 0.5402
    Altitud: 1500

    0.5400737,
            42.586867299999994,
            1506.83
    -------------------------------------------------
    Punto de Destino (Cima del Pico Gallinero):
    Latitud: 42.5912
    Longitud: 0.5511
    Altitud: 2728


            0.5581724,
            42.5541938,
            2147.29
          ]
  */

  //Node startNode = graph.nodes.values.elementAt(200);
  //Node endNode = graph.nodes.values.elementAt(555);

  //Node startNode = graph.findClosestNode(42.5693, 0.5402, 1500);
  //Node endNode = graph.findClosestNode(42.5912, 0.5511, 2728);

  Node startNode = Node(
      latitude: 42.586867299999994,
      longitude: 0.5400737,
      altitude: 1506.83,
      isLift: false);

  Node endNode = Node(
      latitude: 42.5541938,
      longitude: 0.5581724,
      altitude: 2147.29,
      isLift: false);

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
