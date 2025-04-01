enum Role {
  gp('General Purpose', 'GP'),
  sk('Strike', 'SK'),
  rc('Recon', 'RC'),
  fs('Fire Support', 'FS'),
  so('Special Operations', 'SO'),
  eg('Engineering', 'EG'),
  mb('Mobile Base', 'MB'),
  as('Air Support', 'AS'),
  ft('Fortifications', 'FT');

  final String name;
  final String abbreviation;

  const Role(this.name, this.abbreviation);
}
