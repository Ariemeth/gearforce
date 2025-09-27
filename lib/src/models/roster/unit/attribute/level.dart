enum Level {
  green('Green', -1),
  regular('Regular', 0),
  veteran('Veteran', 1),
  elite('Elite', 2);

  final String name;
  final int cost;

  const Level(this.name, this.cost);
}
