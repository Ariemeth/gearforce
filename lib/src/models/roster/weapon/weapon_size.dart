enum WeaponSize {
  light,
  medium,
  heavy;

  static const Map<WeaponSize, String> _prefixes = {
    WeaponSize.light: 'L',
    WeaponSize.medium: 'M',
    WeaponSize.heavy: 'H',
  };

  String get prefix => _prefixes[this]!;

  static WeaponSize fromPrefix(String prefix) {
    if (prefix.trim().isEmpty) {
      throw ArgumentError('Prefix cannot be empty.');
    }
    final upperPrefix = prefix.toUpperCase();
    return _prefixes.entries
        .firstWhere(
          (entry) => entry.value == upperPrefix,
          orElse: () => throw ArgumentError(
            'Invalid prefix: $prefix. Size must be ${_prefixes[WeaponSize.light]}, ${_prefixes[WeaponSize.medium]}, or ${_prefixes[WeaponSize.heavy]}.',
          ),
        )
        .key;
  }

  static WeaponSize fromCode(String weaponCode) {
    if (weaponCode.trim().isEmpty) {
      throw ArgumentError('Weapon code cannot be empty.');
    }
    return fromPrefix(weaponCode[0]);
  }
}
