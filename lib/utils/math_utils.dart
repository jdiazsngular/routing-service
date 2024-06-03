import 'dart:math';

import 'package:routing_service/enums/node_type_enum.dart';
import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/node.dart';
import 'package:routing_service/model/user_option.dart';

class MathUtil {
  static const double _earthRadius = 6378.137;

  static double calculateDistanceByHaversine(Node fromNode, Node toNode) {
    return calculateDistanceByHaversineWithCoordinates(
        fromNode.latitude, fromNode.longitude, toNode.latitude, toNode.longitude);
  }

  static double calculateDistanceByHaversineWithCoordinates(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) {
    var dLat = toLat * pi / 180 - fromLat * pi / 180;
    var dLon = toLong * pi / 180 - fromLong * pi / 180;
    var a =
        sin(dLat / 2) * sin(dLat / 2) + cos(fromLat * pi / 180) * cos(toLat * pi / 180) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return _earthRadius * c * 1000;
  }

  static double calculateFactorFor(Node fromNode, Node toNode, RunType runType, UserOption userOption, double distance, int direction) {
    double factor = 0.0;
    if (fromNode.altitude == null || toNode.altitude == null) return factor;

    if (fromNode.nodeType == NodeType.lift) {
      factor = _getIncreaseFactorWhenGoBackguardsByLift(distance, direction);
    }

    if (fromNode.nodeType == NodeType.run) {
      factor = _getIncreaseFactorWhenGoBackguardsByRun(distance, direction);
      factor += _getFactorWhenRunTypeIsMoreDifficultThanUserLevel(runType, userOption.level, distance);
    }

    return factor;
  }

  static double _getIncreaseFactorWhenGoBackguardsByLift(double distance, int direction) {
    return min(0, distance * direction).toDouble().abs() * 10;
  }

  static double _getIncreaseFactorWhenGoBackguardsByRun(double distance, int direction) {
    return min(0, distance * direction).toDouble().abs() * 15;
  }

  static double _getFactorWhenRunTypeIsMoreDifficultThanUserLevel(
      RunType runType, RunType userLevel, double distance) {
    double factor = 0;
    if (runType.index > userLevel.index) {
      factor = distance * 20;
    }
    return factor;
  }
}
