import 'package:test/test.dart';
import 'package:routing_service/routing_service.dart' as routing_service;

void main() {
  test('calculateRoute Molino to Gallinero', () async {
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> gallineroCoordinates = [42.5441, 0.5556, 2147.29];

    routing_service.calculateRoute(molinoCoordinates, gallineroCoordinates);
  });

  test('calculateRoute Gallinero to Molino', () async {
    List<double> gallineroCoordinates = [42.5441, 0.5556, 2147.29];
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

    routing_service.calculateRoute(gallineroCoordinates, molinoCoordinates);
  });

  test('calculateRoute Molino to Rincon del cielo', () async {
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> rinconDelCieloCoordinates = [42.573172800000016, 0.5415044, 1825.76];

    routing_service.calculateRoute(molinoCoordinates, rinconDelCieloCoordinates);
  });

  test('calculateRoute Rincon del cielo to Molino', () async {
    List<double> rinconDelCieloCoordinates = [42.573172800000016, 0.5415044, 1825.76];
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

    routing_service.calculateRoute(rinconDelCieloCoordinates, molinoCoordinates);
  });

  test('calculateRoute Molino to Castanesa', () async {
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];

    routing_service.calculateRoute(molinoCoordinates, castanesaCoordinates);
  });


  test('calculateRoute Castanesa to Molino', () async {
    List<double> castanesaCoordinates = [42.5523, 0.6062, 2025.8];
    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];

    routing_service.calculateRoute(castanesaCoordinates, molinoCoordinates);
  });
}
