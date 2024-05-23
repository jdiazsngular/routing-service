import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> gallineroCoordinates = [42.54413330000001, 0.5559494000000003, 2604.3500000000004];

  test('calculateRoute Gallinero to Molino with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice, gallineroCoordinates, molinoCoordinates);
  });

  test('calculateRoute Gallinero to Molino with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy, gallineroCoordinates, molinoCoordinates);
  });

  test('calculateRoute Gallinero to Molino with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate, gallineroCoordinates, molinoCoordinates);
  });

  test('calculateRoute Gallinero to Molino with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced, gallineroCoordinates, molinoCoordinates);
  });

  test('calculateRoute Gallinero to Molino with user level expert', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.expert, gallineroCoordinates, molinoCoordinates);
  });

  test('calculateRoute Molino to Gallinero with user level freeride', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.freeride, gallineroCoordinates, molinoCoordinates);
  });
}
