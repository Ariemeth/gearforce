enum MovementType {
  walker('Walker', 'W'),
  ground('Ground', 'G'),
  hover('Hover', 'H');

  final String name;
  final String abbreviation;

  const MovementType(this.name, this.abbreviation);
}
