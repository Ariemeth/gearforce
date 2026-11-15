enum Subfaction {
  // North
  northDefault('None', 'None'),
  norguard('Norguard', 'NG'),
  westernFrontierProtectorate('Western Frontier Protectorate', 'WP'),
  unitedMercantileFederation('United Mercantile Federation', 'UMF'),
  northernLightsConfederacy('Northern Lights Confederacy', 'NLC'),

  // South
  southDefault('None', 'None'),
  southernRepublic('Southern Republic', 'SR'),
  milicia('Military Intervention and Counter Insurgency Army', 'MILICIA'),
  mekongDominion('Mekong Dominion', 'MD'),
  easternSunEmirates('Eastern Sun Emirates', 'ESE'),
  humanistAlliance('Humanist Alliance', 'HA'),

  // NuCoal
  nuCoalDefault('None', 'None'),
  nuCoalSelfDefenseForce('NuCoal Self Defense Force', 'NSDF'),
  portArthurKorps('Port Arthur Korps', 'PAK'),
  khayrAdDin('Khayr ad-Din', 'KAD'),
  templeHeights('Temple Heights', 'TH'),
  hardScrabbledCityStates('Hard Scrabbled City-States', 'HSCS'),

  // Peace River
  peaceRiverDefault('None', 'None'),
  peaceRiverDefenseForce('Peace River Defense Force', 'PRDF'),
  peaceOfficerCorps('Peace Officer Corps', 'POC'),
  paxtonPrivateSecurities('Paxton Private Securities', 'PPS'),

  // Black Talons
  talonDefault('None', 'None'),
  talonReconTeam('Talon Recon Team', 'TRT'),
  talonInsertionTeam('Talon Insertion Team', 'TIT'),
  talonAssaultTeam('Talon Assault Team', 'TAT'),
  talonStrikeTeam('Talon Strike Team', 'TST'),

  // CEF
  cefDefault('None', 'None'),
  expeditionaryForce('Expeditionary Force', 'EF'),
  garrisonForce('Garrison Force', 'GF'),
  earthAdministrationZone('Earth Administration Zone', 'EAZ'),
  rebelForce('Rebel Force', 'RF'),

  // Caprice
  capriceDefault('None', 'None'),
  hakkarSecurity('Hakkar Security', 'HS'),
  costaMoreiaSecurity('Costa Moreia Security', 'CMS'),
  corporatiSecurity('Corporati Security', 'CS'),
  liberatiMilitia('Liberati Militia', 'LM'),

  // Utopia
  utopiaDefault('None', 'None'),
  unitedRepublicOfSteelgate('United Republic of Steelgate', 'URS'),
  industrialStatesOfKogland('Industrial States Of Kogland', 'ISK'),
  greenwayAlliance('Greenway Alliance', 'GA'),
  independentStates('Independent States', 'IS'),
  iAutoP('I-Auto-P', 'IAP'),

  // Eden
  edenDefault('None', 'None'),
  seiathEmpire('Seiath Empire', 'SE'),
  auduuthKingdom('Audu’uth Kingdom', 'AK'),
  muratCorsairs('Murat Corsairs', 'MC'),
  nobleShareholders('Noble Shareholders', 'NS'),
  adHocKingdomOrConsortium('Ad-Hoc Kingdom or Consortium', 'AHKC'),

  // New Jerusalem
  newJerusalemDefault('None', 'None'),
  orderOfSaintMichael('Order of Saint Michael', 'OSM'),
  orderOfSaintGeorge('Order of Saint George', 'OSG'),
  orderOfSaintJoshua('Order of Saint Joshua', 'OSJ');

  final String displayName;
  final String abbreviation;

  const Subfaction(this.displayName, this.abbreviation);
}
