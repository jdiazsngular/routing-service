enum StatusType { operating, unknown }

class StatusTypeMapper {
  static StatusType map(String? value) {
    if (value == null) {
      return StatusType.unknown;
    }
    switch (value) {
      case "operating":
        return StatusType.operating;
      default:
        return StatusType.unknown;
    }
  }
}
