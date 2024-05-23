import 'package:collection/collection.dart';
import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/routing_service.dart' as routing_service;
import 'package:routing_service/utils/geojson_utils.dart';
import 'package:test/test.dart';

class CalculateRouteUtilTest {
  static Future<void> testCalculateRoute(RunType userLevel) async {
    UserOption userOption = UserOption(level: userLevel);
    bool exceptionThrown = false;

    try {
      List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];
      List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

      List<Node> nodes =
          await routing_service.calculateRouteReturnNode(userOption, castanesaCoordinates, molinoCoordinates);

      var invalidRunNodes = nodes
          .where((node) =>
              node.nodeType == NodeType.run && node.runTypes.none((runType) => runType.index <= userOption.level.index))
          .toList();

      // printNodes(invalidRunNodes, userOption);
      // printGeoJson(nodes);

      expect(invalidRunNodes.isEmpty, isTrue, reason: 'The route contains a track higher level than the user.');
    } catch (e) {
      print('Exception caught: $e');
      exceptionThrown = true;
    }

    if (exceptionThrown) {
      expect(exceptionThrown, isTrue, reason: 'There should be a route available within the user\'s skill level');
    }
  }

  static void printGeoJson(List<Node> nodes) {
    final geoJson = GeoJsonUtils.pathToGeoJson(nodes);
    print('GeoJSON:');
    print(geoJson);
  }

  static void printNodes(List<Node> nodes, UserOption userOption) {
    for (var node in nodes) {
      if (node.nodeType == NodeType.run) {
        print(
            'Nodo: ${node.names} ${node.latitude} ${node.longitude} ${node.altitude}, RunType: ${node.runTypes}, Nivel de usuario: ${userOption.level}');
      }
    }
  }
}
