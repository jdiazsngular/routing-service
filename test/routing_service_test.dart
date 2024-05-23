import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:test/test.dart';
import 'package:routing_service/routing_service.dart' as routing_service;

void main() {
  UserOption userOption = UserOption(level: RunType.easy);
  const String notFoundReason = "coordinates not found in GeoJSON";

  test('calculateRoute Molino to Gallinero', () async {
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> gallineroCoordinates = [42.54413330000001, 0.5559494000000003, 2604.3500000000004];

    var geojson = await routing_service.calculateRoute(userOption, molinoCoordinates, gallineroCoordinates);

    List<double> step1 = [0.5400737,42.586867299999994,1506.83];
    var postion = step1.toString().replaceAll(" ", "");

    expect(geojson.contains(postion), isTrue, reason: notFoundReason);
  });

  test('calculateRoute Gallinero to Molino', () async {
    List<double> gallineroCoordinates = [42.54413330000001, 0.5559494000000003, 2604.3500000000004];
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

    var geojson = await routing_service.calculateRoute(userOption, gallineroCoordinates, molinoCoordinates);

    List<double> step1 = [0.5400737,42.586867299999994,1506.83];
    var postion = step1.toString().replaceAll(" ", "");

    expect(geojson.contains(postion), isTrue, reason: notFoundReason);
  });

  test('calculateRoute Molino to Rincon del cielo', () async {
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> rinconDelCieloCoordinates = [42.573172800000016, 0.5415044, 1825.76];

    var geojson = await routing_service.calculateRoute(userOption, molinoCoordinates, rinconDelCieloCoordinates);

    List<double> step1 = [0.5400737,42.586867299999994,1506.83];
    var postion = step1.toString().replaceAll(" ", "");

    expect(geojson.contains(postion), isTrue, reason: notFoundReason);
  });

  test('calculateRoute Rincon del cielo to Molino', () async {
    List<double> rinconDelCieloCoordinates = [42.573172800000016, 0.5415044, 1825.76];
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

    var geojson = await routing_service.calculateRoute(userOption, rinconDelCieloCoordinates, molinoCoordinates);

    List<double> step1 = [0.5400737,42.586867299999994,1506.83];
    var postion = step1.toString().replaceAll(" ", "");

    expect(geojson.contains(postion), isTrue, reason: notFoundReason);
  });

  test('calculateRoute Molino to Castanesa', () async {
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];

    var geojson = await routing_service.calculateRoute(userOption, molinoCoordinates, castanesaCoordinates);

    List<double> step1 = [0.5400737,42.586867299999994,1506.83];
    var postion = step1.toString().replaceAll(" ", "");

    expect(geojson.contains(postion), isTrue, reason: notFoundReason);
  });

  test('calculateRoute Castanesa to Molino', () async {
    List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

    var geojson = await routing_service.calculateRoute(userOption, castanesaCoordinates, molinoCoordinates);

    List<double> step1 = [0.5400737,42.586867299999994,1506.83];
    var postion = step1.toString().replaceAll(" ", "");

    expect(geojson.contains(postion), isTrue, reason: notFoundReason);
  });
}
