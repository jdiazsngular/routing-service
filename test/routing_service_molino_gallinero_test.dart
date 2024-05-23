import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> gallineroCoordinates = [42.54413330000001, 0.5559494000000003, 2604.3500000000004];

  test('calculateRoute Molino to Gallinero with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice, molinoCoordinates, gallineroCoordinates);
  });

  test('calculateRoute Molino to Gallinero with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy, molinoCoordinates, gallineroCoordinates);
  });

  test('calculateRoute Molino to Gallinero with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate, molinoCoordinates, gallineroCoordinates);
  });

  test('calculateRoute Molino to Gallinero with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced, molinoCoordinates, gallineroCoordinates);
  });

  test('calculateRoute Molino to Gallinero with user level expert', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.expert, molinoCoordinates, gallineroCoordinates);
  });

  test('calculateRoute Molino to Gallinero with user level freeride', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.freeride, molinoCoordinates, gallineroCoordinates);
  });
}
