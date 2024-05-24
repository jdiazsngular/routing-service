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

  static double calculateFactorFor(Node fromNode, Node toNode, RunType runType, UserOption userOption) {
    double factor = 0.0;
    if (fromNode.altitude == null || toNode.altitude == null) return factor;

    double unevenness = toNode.altitude! - fromNode.altitude!;
    
    if (fromNode.nodeType == NodeType.lift) {
      double increaseFactorWhenGoDownByLift = min(0, unevenness).toDouble().abs() * 3;
      factor = increaseFactorWhenGoDownByLift;
    }

    if (fromNode.nodeType == NodeType.run) {
      double increseFactorWhenGoUpByRun = max(0, unevenness) * 3;
      factor = increseFactorWhenGoUpByRun;

      factor = increaseFactorWhenRunTypeIsMoreDifficultThanUserLevel(runType, userOption.level, unevenness);
    }

    return factor;
  }

  static double increaseFactorWhenRunTypeIsMoreDifficultThanUserLevel(RunType runType, RunType userLevel, double unevenness) {
    double factor = 0;
    if (runType.index > userLevel.index) {
      factor = unevenness.abs() * 20;
    }
    return factor;
  }
}
