enum Level {
  green('Green', '1'),
  regular('Regular', '2'),
  veteran('Veteran', '3'),
  elite('Elite', '4');

  final String name;
  final String id;

  const Level(this.name, this.id);
}
