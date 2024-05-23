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
    if (userOption.level == RunType.freeride || fromNode.altitude == null || toNode.altitude == null) {
      return 0.0;
    }

    double unevenness = toNode.altitude! - fromNode.altitude!;
    double factor = 0.0;

    if (unevenness > 0) {
      if (fromNode.nodeType == NodeType.lift) {
        factor = 0.1;
      } else if (fromNode.nodeType == NodeType.run) {
        factor = unevenness * 1000;
        if (runType.index > userOption.level.index) {
          factor *= 10;
        }
      }
    } else {
      if (fromNode.nodeType == NodeType.run) {
        factor = unevenness.abs() * 3;
        if (runType.index > userOption.level.index) {
          factor *= 1000;
        }
      } else if (fromNode.nodeType == NodeType.lift) {
        factor = unevenness.abs();
      }
    }

    return factor;
  }

    static double calculateFactorForOld(Node fromNode, Node toNode, UserOption userOption, RunType? runType) {
    double factor = 0.0;
    if (fromNode.altitude == null || toNode.altitude == null) return factor;

    double unevenness = toNode.altitude! - fromNode.altitude!;
    if (fromNode.nodeType == NodeType.lift) {
      factor = min(0, unevenness).toDouble().abs();
    }

    if (fromNode.nodeType == NodeType.run) {
      factor = max(0, unevenness) * 3;

      if (runType!.index > userOption.level.index) {
        factor = unevenness.abs() * 100;
      }
    }

    return factor;
  }
}
