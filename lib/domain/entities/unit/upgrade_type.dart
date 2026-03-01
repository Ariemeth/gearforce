enum UpgradeType {
  profile('profile'),
  command('command'),
  cg('cg'),
  squad('squad'),
  unit('unit'),
  blitz('blitz'),
  fieldGuide('fieldGuide');

  final String value;

  const UpgradeType(this.value);

  factory UpgradeType.fromString(String value) {
    return UpgradeType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => UpgradeType.profile, // default to profile if not found
    );
  }
}
