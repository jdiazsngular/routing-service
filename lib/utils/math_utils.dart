import 'dart:math';

import 'package:routing_service/model/node.dart';

class MathUtil {
  static const double _earthRadius = 6378.137;

  /*static double calculateDistanceByEuclidiana(Node fromNode, Node toNode) {
    return sqrt(pow(toNode.latitude - fromNode.latitude, 2) +
        pow(toNode.longitude - fromNode.longitude, 2) +
        pow(toNode.altitude - fromNode.altitude, 2));
  }*/

  static double calculateDistanceByHaversine(Node fromNode, Node toNode) {
    return calculateDistanceByHaversineWithCoordinates(fromNode.latitude,
        fromNode.longitude, toNode.latitude, toNode.longitude);
  }

  static double calculateDistanceByHaversineWithCoordinates(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) {
    var dLat = toLat * pi / 180 - fromLat * pi / 180;
    var dLon = toLong * pi / 180 - fromLong * pi / 180;
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(fromLat * pi / 180) *
            cos(toLat * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return _earthRadius * c * 1000;
  }
}
