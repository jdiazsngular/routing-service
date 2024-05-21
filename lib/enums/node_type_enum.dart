enum NodeType { lift, run, connection }

class NodeTypeMapper {
  static NodeType map(String value) {
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
