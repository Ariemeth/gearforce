enum WeaponSize {
  small,
  medium,
  large;

  static WeaponSize fromCode(String code) {
    switch (code[0].toUpperCase()) {
      case 'S':
        return WeaponSize.small;
      case 'M':
        return WeaponSize.medium;
      case 'L':
        return WeaponSize.large;
      default:
        throw ArgumentError(
            'Invalid weapon code: $code. Size must be S, M, or L.');
    }
  }
}
