import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/step.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/routing_service.dart' as routing_service;
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';
import 'features/cerler_fixtures.dart';

void main() {
  group("Calculate Route from", () {
    test('Castanea to molino with user level novice', () async {
      UserOption userOption = UserOption(level: RunType.novice);

      List<Step> steps = await routing_service.calculateRouteSteps(
          userOption, CerlerFixture.castanesaBottomLiftCoordinates, CerlerFixture.molinoBottomLiftCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(18));
      expect(steps, hasLength(129));
      expect(steps, containsCoordinates(CerlerFixture.basibeTopLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.ampriuBottomLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.sarrauTopLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.molinoTopLiftCoordinates));
    });

    test('Castanea to molino with user level easy', () async {
      UserOption userOption = UserOption(level: RunType.easy);

      List<Step> steps = await routing_service.calculateRouteSteps(
          userOption, CerlerFixture.castanesaBottomLiftCoordinates, CerlerFixture.molinoBottomLiftCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(1));
      expect(steps, hasLength(148));
      expect(steps, containsCoordinates(CerlerFixture.basibeNouFontsRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.basibeRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.batisiellesTopLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.barrancoRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.lesPlanesRunCoordinates));
    });

    test('calculateRoute Castanea to molino with user level intermediate', () async {
      UserOption userOption = UserOption(level: RunType.intermediate);

      //List<Step> steps = await routing_service.calculateRouteSteps(
      //    userOption, CerlerFixture.castanesaBottomLiftCoordinates, CerlerFixture.molinoBottomLiftCoordinates);

      List<Step> steps = await routing_service.calculateLongestRouteSteps(
          userOption, CerlerFixture.castanesaBottomLiftCoordinates, CerlerFixture.molinoBottomLiftCoordinates);

      CalculateRouteUtilTest.printGeoJson(steps);

      //CalculateRouteUtilTest.printGeoJson(steps);
      //CalculateRouteUtilTest.printGeoJson(steps2);

      /* var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(0));
      expect(steps, hasLength(128));
      expect(steps, containsCoordinates(CerlerFixture.castanesaBottomLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.basibeNouFontsRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.laFetiellaRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.batisiellesTopLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.barrancoRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.fontanalsRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.molinoBottomLiftCoordinates));*/
    });

    test('calculateRoute Castanea to molino with user level advanced', () async {
      UserOption userOption = UserOption(level: RunType.advanced);

      List<Step> steps = await routing_service.calculateRouteSteps(
          userOption, CerlerFixture.castanesaBottomLiftCoordinates, CerlerFixture.molinoBottomLiftCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(0));
      expect(steps, hasLength(131));
      expect(steps, containsCoordinates(CerlerFixture.basibeNouFontsRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.pasoLobinoRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.ampriuBottomLiftCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.muidorsRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.fontanalsRunCoordinates));
      expect(steps, containsCoordinates(CerlerFixture.molinoBottomLiftCoordinates));
    });
  });

  group("Calculate alternate Routes from", () {
    test("Castena to molino with user level advanced", () async {
      UserOption userOption = UserOption(level: RunType.advanced);

      var list = await routing_service.calculateAlternateRoute(
          userOption, CerlerFixture.castanesaBottomLiftCoordinates, CerlerFixture.molinoBottomLiftCoordinates, 3);

      expect(list, hasLength(3));
      expect(list.first, hasLength(131));
      expect(list.elementAt(1), hasLength(168));
      expect(list.last, hasLength(150));
    });
  });
}

Matcher containsCoordinates(List<double> coordinates) =>
    contains(predicate<Step>((s) => s.node.toString() == coordinates.toString()));
