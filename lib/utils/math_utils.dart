import 'dart:math';

import 'package:routing_service/model/node.dart';

class MathUtil {
  static const double _earthRadius = 6378.137;

  static double calculateDistanceByEuclidiana(Node fromNode, Node toNode) {
    return sqrt(pow(toNode.latitude - fromNode.latitude, 2) +
        pow(toNode.longitude - fromNode.longitude, 2) +
        pow(toNode.altitude - fromNode.altitude, 2));
  }

  static double calculateDistanceByHaversine(Node fromNode, Node toNode) {
    var dLat = toNode.latitude * pi / 180 - fromNode.latitude * pi / 180;
    var dLon = toNode.longitude * pi / 180 - fromNode.longitude * pi / 180;
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(fromNode.latitude * pi / 180) *
            cos(toNode.latitude * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return _earthRadius * c * 1000;
  }
}
