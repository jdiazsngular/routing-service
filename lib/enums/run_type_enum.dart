enum RunType {
  unknown,
  connection,
  novice,
  easy,
  intermediate,
  advanced,
  expert,
  freeride,
}

class RunTypeMapper {
  static RunType map(String? value) {
    if (value == null) {
      return RunType.unknown;
    }
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
