enum UpgradeType {
  core('core'),
  unit('unit'),
  squad('squad'),
  command('command');

  final String value;

  const UpgradeType(this.value);

  factory UpgradeType.fromString(String value) {
    return UpgradeType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => UpgradeType.unit, // default to unit if not found
    );
  }
}
