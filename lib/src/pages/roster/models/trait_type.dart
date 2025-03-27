enum TraitType {
  drones('Drones',
      'This unit may transport X number of units with the Subtype drone. Ex: the Recon Hun may carry 3 drones.'),
  nKIDUs('N-KIDUs',
      'This unit may transport X number of N-KIDU automatons.\n- 1 infantry Team or infantry Single may be substituted for 1 N-KIDU.'),
  armigers('Armigers',
      'This unit may transport X number of armigers.\n-- 4 N-KIDUs may be substituted for 1 armiger.\n-- 1 infantry Cadre may be substituted for 1 armiger.\n-- 3 infantry Teams or infantry Singles may be substituted for 1 armiger.'),
  cadres('Cadres',
      'This unit may transport up to X number of infantry Cadres.\n- 3 infantry Teams or infantry Singles may be substituted for 1 infantry Cadre.\n- 3 drones may be substituted for 1 infantry Cadre.'),
  teams('Teams',
      'This unit may transport up to X number of infantry Teams.\n- Infantry Singles may be used instead, one for one.\n- One drone may take the place of one infantry Team.'),
  gears('Gears',
      'This unit may transport X number of gears.\n- 1 infantry Cadre may be substituted for 1 gear.\n- 3 infantry Teams or infantry Singles may be substituted for 1 gear.\n- 3 drones may be substituted for 1 gear.'),
  f('F', 'Fire.'),
  c('C', 'Corrosion.'),
  h('H', 'Haywire.');

  final String value;
  final String description;

  const TraitType(this.value, this.description);
}
