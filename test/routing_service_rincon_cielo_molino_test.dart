import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  test('calculateRoute Rincon cielo to Molino with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice);
  });

  test('calculateRoute Rincon cielo to Molino with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy);
  });

  test('calculateRoute Rincon cielo to Molino with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate);
  });

  test('calculateRoute Rincon cielo to Molino with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced);
  });
}
