import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  test('calculateRoute Molino to Gallinero with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice);
  });

  test('calculateRoute Molino to Gallinero with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy);
  });

  test('calculateRoute Molino to Gallinero with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate);
  });

  test('calculateRoute Molino to Gallinero with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced);
  });

  test('calculateRoute Molino to Gallinero with user level expert', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.expert);
  });

  test('calculateRoute Molino to Gallinero with user level freeride', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.freeride);
  });
}
