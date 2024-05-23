import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> rinconDelCieloCoordinates = [42.573172800000016, 0.5415044, 1825.76];
  test('calculateRoute Molino to Rincon cielo with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice, molinoCoordinates, rinconDelCieloCoordinates);
  });

  test('calculateRoute Molino to Rincon cielo with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy, molinoCoordinates, rinconDelCieloCoordinates);
  });

  test('calculateRoute Molino to Rincon cielo with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate, molinoCoordinates, rinconDelCieloCoordinates);
  });

  test('calculateRoute Molino to Rincon cielo with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced, molinoCoordinates, rinconDelCieloCoordinates);
  });

  test('calculateRoute Molino to Rincon cielo with user level expert', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.expert, molinoCoordinates, rinconDelCieloCoordinates);
  });

  test('calculateRoute Molino to Rincon cielo with user level freeride', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.freeride, molinoCoordinates, rinconDelCieloCoordinates);
  });
}
