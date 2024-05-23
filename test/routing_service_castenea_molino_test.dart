import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];

  test('calculateRoute Castanea to molino with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice, castanesaCoordinates, molinoCoordinates);
  });

  test('calculateRoute Castanea to molino with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy, castanesaCoordinates, molinoCoordinates);
  });

  test('calculateRoute Castanea to molino with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate, castanesaCoordinates, molinoCoordinates);
  });

  test('calculateRoute Castanea to molino with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced, castanesaCoordinates, molinoCoordinates);
  });
}
