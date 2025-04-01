enum Command {
  none('none', '0'),
  secondIC('2iC', '1'),
  firstIC('1iC', '2'),
  co('CO', '3'),
  xo('XO', '4');

  final String name;
  final String id;

  const Command(this.name, this.id);
}
