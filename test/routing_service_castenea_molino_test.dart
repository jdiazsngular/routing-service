import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/service/route_algorithm_service.dart';
import 'package:routing_service/routing_service.dart' as routing_service;
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  group("Calculate Route from", () {
    test('Castanea to molino with user level novice', () async {
      UserOption userOption = UserOption(level: RunType.novice);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomCoordinates, Fixture.molinoBottomCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(18));
      expect(steps, containsCoordinates(Fixture.basibeTopCoordinates));
      expect(steps, containsCoordinates(Fixture.ampriuBottomCoordinates));
      expect(steps, containsCoordinates(Fixture.sarrauTopCoordinates));
      expect(steps, containsCoordinates(Fixture.molinoTopCoordinates));
    });

    test('Castanea to molino with user level easy', () async {
      UserOption userOption = UserOption(level: RunType.easy);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomCoordinates, Fixture.molinoBottomCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(1));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.basibeTopCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.ampriuBottomCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.sarrauTopCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.molinoTopCoordinates.toString())));
    });

    test('calculateRoute Castanea to molino with user level intermediate', () async {
      UserOption userOption = UserOption(level: RunType.intermediate);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomCoordinates, Fixture.molinoBottomCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(18));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.basibeTopCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.ampriuBottomCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.sarrauTopCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.molinoTopCoordinates.toString())));
    });

    test('calculateRoute Castanea to molino with user level advanced', () async {
      UserOption userOption = UserOption(level: RunType.advanced);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomCoordinates, Fixture.molinoBottomCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(18));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.basibeTopCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.ampriuBottomCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.sarrauTopCoordinates.toString())));
      expect(steps, contains(predicate<Step>((s) => s.node.toString() == Fixture.molinoTopCoordinates.toString())));
    });
  });

  test("Castena to molino with user level intermediate", () async {
    UserOption userOption = UserOption(level: RunType.advanced);

    var list = await routing_service.calculateAlternateRoute(
        userOption, Fixture.castanesaBottomCoordinates, Fixture.molinoBottomCoordinates, 2);
    
    CalculateRouteUtilTest.printNodes(list.first);
  });
}

Matcher containsCoordinates(List<double> coordinates) =>
    contains(predicate<Step>((s) => s.node.toString() == coordinates.toString()));

class Fixture {
  static final List<double> basibeTopCoordinates = [42.5500312, 0.5897593, 2360.42];
  static final List<double> ampriuBottomCoordinates = [42.5619005, 0.5676171, 1901.6499999999999];
  static final List<double> sarrauTopCoordinates = [42.5616022, 0.5525032, 2314.27];
  static final List<double> molinoTopCoordinates = [42.567049499999996, 0.5418477, 2011.29];
  static final List<double> molinoBottomCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  static final List<double> castanesaBottomCoordinates = [42.5523, 0.6062, 2025.8];
}
