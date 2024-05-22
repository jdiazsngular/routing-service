enum NodeType { lift, run, connection, unknown }

class NodeTypeMapper {
  static NodeType map(String? value) {
    if (value == null) {
      return NodeType.unknown;
    }
    switch (value) {
      case "lift":
        return NodeType.lift;
      case "connection":
        return NodeType.connection;
      default:
        return NodeType.run;
    }
  }
}
