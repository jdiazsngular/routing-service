enum PisteType {
  novice,
  easy,
  intermediate,
  advanced,
  expert,
  freeride,
  connection,
  unknown,
}

class PisteTypeMapper {
  static PisteType map(String value) {
    switch (value.toLowerCase()) {
      case 'novice':
        return PisteType.novice;
      case 'easy':
        return PisteType.easy;
      case 'intermediate':
        return PisteType.intermediate;
      case 'advanced':
        return PisteType.advanced;
      case 'expert':
        return PisteType.expert;
      case 'freeride':
        return PisteType.freeride;
      case 'connection':
        return PisteType.connection;
      default:
        return PisteType.unknown;
    }
  }
}
