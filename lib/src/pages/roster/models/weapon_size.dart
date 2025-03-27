enum WeaponSize {
  small,
  medium,
  large;

  static const Map<WeaponSize, String> _prefixes = {
    WeaponSize.small: 'S',
    WeaponSize.medium: 'M',
    WeaponSize.large: 'L',
  };

  String get prefix => _prefixes[this]!;

  static WeaponSize fromCode(String weaponCode) {
    if (weaponCode.isEmpty) {
      throw ArgumentError('Weapon code cannot be empty.');
    }
    final prefix = weaponCode[0].toUpperCase();
    return _prefixes.entries
        .firstWhere(
          (entry) => entry.value == prefix,
          orElse: () => throw ArgumentError(
              'Invalid weapon code: $weaponCode. Size must be ${_prefixes[WeaponSize.small]}, ${_prefixes[WeaponSize.medium]}, or ${_prefixes[WeaponSize.large]}.'),
        )
        .key;
  }
}
