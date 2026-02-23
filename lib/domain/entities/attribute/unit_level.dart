enum UnitLevel {
  green('Green', -1),
  regular('Regular', 0),
  veteran('Veteran', 1),
  elite('Elite', 2);

  final String name;
  final int cost;

  const UnitLevel(this.name, this.cost);
}
