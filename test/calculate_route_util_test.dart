import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/routing_service.dart' as routing_service;
import 'package:routing_service/service/route_algorithm_service.dart';
import 'package:routing_service/utils/geojson_utils.dart';
import 'package:test/test.dart';

class CalculateRouteUtilTest {
  static Future<void> testCalculateRoute(
      RunType userLevel, List<double> startCoordinates, List<double> endCoordinates) async {
    UserOption userOption = UserOption(level: userLevel);
    bool exceptionThrown = false;

    try {
      List<Step> steps = await routing_service.calculateRouteSteps(userOption, startCoordinates, endCoordinates);

      var invalidRunStep = routing_service.getInvalidRunSteps(steps, userOption.level);

      print("----------------- User Level: $userLevel -----------------");
      printNodes(invalidRunStep);
      printGeoJson(steps);

      expect(invalidRunStep.isEmpty, isTrue, reason: 'The route contains a track higher level than the user.');
    } catch (e) {
      print('Exception caught: $e');
      exceptionThrown = true;
    }

    if (exceptionThrown) {
      expect(exceptionThrown, isTrue, reason: 'There should be a route available within the user\'s skill level');
    }
  }

  static void printGeoJson(List<Step> steps) {
    final geoJson = GeoJsonUtils.pathToGeoJson(steps);
    print('**** GeoJSON ****');
    print(geoJson);
  }

  static void printNodes(List<Step> steps) {
    for (var step in steps) {
      if (step.node.nodeType == NodeType.run) {
        print('Step: ${step.node.latitude} ${step.node.longitude} ${step.node.altitude}, RunType: ${step.runType}');
      }
    }
  }
}
