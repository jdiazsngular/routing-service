import 'package:routing_service/enums/run_type_enum.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  test('calculateRoute Castanea to molino with user level novice', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.novice);
  });

  test('calculateRoute Castanea to molino with user level easy', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.easy);
  });

  test('calculateRoute Castanea to molino with user level intermediate', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.intermediate);
  });

  test('calculateRoute Castanea to molino with user level advanced', () async {
    await CalculateRouteUtilTest.testCalculateRoute(RunType.advanced);
  });
}
