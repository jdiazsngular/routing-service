import 'package:routing_service/enums/run_type_enum.dart';
import 'package:routing_service/model/user_option.dart';
import 'package:routing_service/routing_service.dart' as routing_service;

void main(List<String> arguments) {
  UserOption userOption = UserOption(level: RunType.intermediate);
  List<double> molinoCoordinates = [42.586867299999994, 0.5400737, 1506.83];
  List<double> gallineroCoordinates = [42.5441, 0.5556, 2147.29];

  routing_service.calculateRoute(
      userOption, molinoCoordinates, gallineroCoordinates);
  //routing_service.calculateRoute(
  //    userOption, gallineroCoordinates, molinoCoordinates);
}
