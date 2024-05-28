import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/service/route_algorithm_service.dart';
import 'package:routing_service/routing_service.dart' as routing_service;
import 'package:routing_service/utils/geojson_utils.dart';
import 'package:test/test.dart';

import 'calculate_route_util_test.dart';

void main() {
  group("Calculate Route from", () {
    test('Castanea to molino with user level novice', () async {
      UserOption userOption = UserOption(level: RunType.novice);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomLiftCoordinates, Fixture.molinoBottomLiftCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(18));
      expect(steps, containsCoordinates(Fixture.basibeTopLiftCoordinates));
      expect(steps, containsCoordinates(Fixture.ampriuBottomLiftCoordinates));
      expect(steps, containsCoordinates(Fixture.sarrauTopLiftCoordinates));
      expect(steps, containsCoordinates(Fixture.molinoTopLiftCoordinates));
    });

    test('Castanea to molino with user level easy', () async {
      UserOption userOption = UserOption(level: RunType.easy);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomLiftCoordinates, Fixture.molinoBottomLiftCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(1));
      expect(steps, containsCoordinates(Fixture.basibeNouFontsRunCoordinates));
      expect(steps, containsCoordinates(Fixture.basibeRunCoordinates));
      expect(steps, containsCoordinates(Fixture.batisiellesTopLiftCoordinates));
      expect(steps, containsCoordinates(Fixture.barrancoRunCoordinates));
      expect(steps, containsCoordinates(Fixture.lesPlanesRunCoordinates));
    });

    test('calculateRoute Castanea to molino with user level intermediate', () async {
      UserOption userOption = UserOption(level: RunType.intermediate);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomLiftCoordinates, Fixture.molinoBottomLiftCoordinates);

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(0));
      expect(steps, containsCoordinates(Fixture.castanesaBottomLiftCoordinates));
      expect(steps, containsCoordinates(Fixture.basibeNouFontsRunCoordinates));
      expect(steps, containsCoordinates(Fixture.laFetiellaRunCoordinates));
      expect(steps, containsCoordinates(Fixture.batisiellesTopLiftCoordinates));
      expect(steps, containsCoordinates(Fixture.barrancoRunCoordinates));
      expect(steps, containsCoordinates(Fixture.fontanalsRunCoordinates));
      expect(steps, containsCoordinates(Fixture.molinoBottomLiftCoordinates));
    });

    test('calculateRoute Castanea to molino with user level advanced', () async {
      UserOption userOption = UserOption(level: RunType.advanced);

      List<Step> steps = await routing_service.calculateRouteReturnNode(
          userOption, Fixture.castanesaBottomLiftCoordinates, Fixture.molinoBottomLiftCoordinates);

      print(GeoJsonUtils.pathToGeoJson(steps));

      var invalidRunSteps = routing_service.getInvalidRunSteps(steps, userOption.level);
      expect(invalidRunSteps, hasLength(0));
      expect(steps, containsCoordinates(Fixture.basibeNouFontsRunCoordinates));
      expect(steps, containsCoordinates(Fixture.pasoLobinoRunCoordinates));
      expect(steps, containsCoordinates(Fixture.ampriuBottomLiftCoordinates));
    });
  });

  test("Castena to molino with user level intermediate", () async {
    UserOption userOption = UserOption(level: RunType.advanced);

    var list = await routing_service.calculateAlternateRoute(
        userOption, Fixture.castanesaBottomLiftCoordinates, Fixture.molinoBottomLiftCoordinates, 3);
        
    expect(list, hasLength(3));
    print(GeoJsonUtils.pathToGeoJson(list.first));
    print(GeoJsonUtils.pathToGeoJson(list.elementAt(1)));
    print(GeoJsonUtils.pathToGeoJson(list.last));
  });
}

Matcher containsCoordinates(List<double> coordinates) =>
    contains(predicate<Step>((s) => s.node.toString() == coordinates.toString()));

class Fixture {
  static final List<double> basibeTopLiftCoordinates = [42.5500312, 0.5897593, 2360.42];
  static final List<double> ampriuBottomLiftCoordinates = [42.5619005, 0.5676171, 1901.6499999999999];
  static final List<double> sarrauTopLiftCoordinates = [42.5616022, 0.5525032, 2314.27];
  static final List<double> molinoTopLiftCoordinates = [42.567049499999996, 0.5418477, 2011.29];
  static final List<double> molinoBottomLiftCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  static final List<double> castanesaBottomLiftCoordinates = [42.552251, 0.6062035, 2025.8];
  static final List<double> batisiellesTopLiftCoordinates = [42.554961899999995, 0.5531225, 2251.9500000000003];

  static final List<double> basibeNouFontsRunCoordinates = [42.55187939999999, 0.5903671999999996, 2324.7];
  static final List<double> basibeRunCoordinates = [42.5536956, 0.5813788999999998, 2165.59];
  static final List<double> barrancoRunCoordinates = [42.558192300000016, 0.5486167, 2183.74];
  static final List<double> lesPlanesRunCoordinates = [42.574269099999995, 0.5414334, 1799.3];
  static final List<double> laFetiellaRunCoordinates = [42.55398639999999, 0.5867157, 2187.54];
  static final List<double> fontanalsRunCoordinates = [42.57232560000001, 0.54432, 1882.8];
  static final List<double> pasoLobinoRunCoordinates = [42.554481999999986, 0.5865514999999998, 2183.84];
}
