import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];

  test('calculateRoute Molino to Castanea with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice, molinoCoordinates, castanesaCoordinates);
  });

  test('calculateRoute Molino to Castanea with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy, molinoCoordinates, castanesaCoordinates);
  });

  test('calculateRoute Molino to Castanea with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate, molinoCoordinates, castanesaCoordinates);
  });

  test('calculateRoute Molino to Castanea with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced, molinoCoordinates, castanesaCoordinates);
  });

  test('calculateRoute Molino to Castanea with user level expert', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.expert, molinoCoordinates, castanesaCoordinates);
  });

  test('calculateRoute Molino to Castanea with user level freeride', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.freeride, molinoCoordinates, castanesaCoordinates);
  });
}
