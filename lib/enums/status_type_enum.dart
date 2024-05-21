enum StatusType { operating, unknown }

class StatusTypeMapper {
  static StatusType map(String value) {
    switch (value) {
      case "operating":
        return StatusType.operating;
      default:
        return StatusType.unknown;
    }
  }
}
