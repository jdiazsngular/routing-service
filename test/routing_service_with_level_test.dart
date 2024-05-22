import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/utils/geojson_utils.dart';
import 'package:test/test.dart';
import 'package:routing_service/routing_service.dart' as routing_service;

void main() {
  test('calculateRoute Molino to Gallinero with user level', () async {
    UserOption userOption = UserOption(level: RunType.intermediate);

    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> gallineroCoordinates = [
      42.54413330000001,
      0.5559494000000003,
      2604.3500000000004
    ];

    List<Node> nodes = await routing_service.calculateRouteReturnNode(
        userOption, molinoCoordinates, gallineroCoordinates);

    var invalidRunNodes = nodes
        .where((node) =>
            node.nodeType == NodeType.run &&
            node.runType.index > userOption.level.index)
        .toList();

    final geoJson = GeoJsonUtils.pathToGeoJson(nodes);
    print('GeoJSON:');
    print(geoJson);

    expect(invalidRunNodes.isEmpty, isTrue,
        reason: 'The route contains a track higher level than the user.');
  });

  test('calculateRoute Gallinero to Molino with user level', () async {
    UserOption userOption = UserOption(level: RunType.intermediate);

    List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
    List<double> gallineroCoordinates = [
      42.54413330000001,
      0.5559494000000003,
      2604.3500000000004
    ];

    List<Node> nodes = await routing_service.calculateRouteReturnNode(
        userOption, gallineroCoordinates, molinoCoordinates);

    var invalidRunNodes = nodes
        .where((node) =>
            node.nodeType == NodeType.run &&
            node.runType.index > userOption.level.index)
        .toList();

    for (var node in invalidRunNodes) {
      print(
          'Nodo inválido: ${node.name} ${node.latitude} ${node.longitude} ${node.altitude}, RunType: ${node.runType}, Nivel de usuario: ${userOption.level}');
    }

    final geoJson = GeoJsonUtils.pathToGeoJson(nodes);
    print('GeoJSON:');
    print(geoJson);

    expect(invalidRunNodes.isEmpty, isTrue,
        reason: 'The route contains a track higher level than the user.');
  });
}
