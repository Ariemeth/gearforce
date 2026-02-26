enum Command {
  none('none', 0),
  secondIC('2iC', 1),
  firstIC('1iC', 1),
  co('CO', 2),
  xo('XO', 3);

  final String name;
  final int cost;

  const Command(this.name, this.cost);
}
