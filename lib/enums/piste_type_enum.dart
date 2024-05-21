enum RunType {
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
  static RunType map(String value) {
    switch (value.toLowerCase()) {
      case 'novice':
        return RunType.novice;
      case 'easy':
        return RunType.easy;
      case 'intermediate':
        return RunType.intermediate;
      case 'advanced':
        return RunType.advanced;
      case 'expert':
        return RunType.expert;
      case 'freeride':
        return RunType.freeride;
      case 'connection':
        return RunType.connection;
      default:
        return RunType.unknown;
    }
  }
}
