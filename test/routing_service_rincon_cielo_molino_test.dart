import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> rinconDelCieloCoordinates = [42.573172800000016, 0.5415044, 1825.76];

  test('calculateRoute Rincon cielo to Molino with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice, rinconDelCieloCoordinates, molinoCoordinates);
  });

  test('calculateRoute Rincon cielo to Molino with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy, rinconDelCieloCoordinates, molinoCoordinates);
  });

  test('calculateRoute Rincon cielo to Molino with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate, rinconDelCieloCoordinates, molinoCoordinates);
  });

  test('calculateRoute Rincon cielo to Molino with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced, rinconDelCieloCoordinates, molinoCoordinates);
  });

  test('calculateRoute Rincon cielo to Molino with user level expert', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.expert, rinconDelCieloCoordinates, molinoCoordinates);
  });

  test('calculateRoute Rincon cielo to Molino with user level freeride', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.freeride, rinconDelCieloCoordinates, molinoCoordinates);
  });
}
