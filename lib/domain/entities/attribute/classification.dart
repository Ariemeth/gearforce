enum Classification {
  cavalry('Cavalry'),
  counter('Counter'),
  fortifications('Fortifications'),
  gear('Gear'),
  infantry('Infantry'),
  strider('Strider'),
  terrain('Terrain'),
  unknown('Unknown');

  final String name;

  const Classification(this.name);
}
