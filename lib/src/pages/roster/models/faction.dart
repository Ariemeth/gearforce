import 'package:gearforce/src/pages/roster/models/subfaction.dart';

enum Faction {
  blackTalons('Black Talons', [
    Subfaction.talonReconTeam,
    Subfaction.talonInsertionTeam,
    Subfaction.talonAssaultTeam,
    Subfaction.talonStrikeTeam,
  ]),
  cef('CEF', [
    Subfaction.expeditionaryForce,
    Subfaction.garrisonForce,
    Subfaction.earthAdministrationZone,
    Subfaction.rebelForce,
  ]),
  caprice('Caprice', [
    Subfaction.hakkarSecurity,
    Subfaction.costaMoreiaSecurity,
    Subfaction.corporatiSecurity,
    Subfaction.liberatiMilitia,
  ]),
  eden('Eden', [
    Subfaction.seiathEmpire,
    Subfaction.auduuthKingdom,
    Subfaction.muratCorsairs,
    Subfaction.nobleShareholders,
    Subfaction.adHocKingdomOrConsortium,
  ]),
  north('North', [
    Subfaction.norguard,
    Subfaction.westernFrontierProtectorate,
    Subfaction.unitedMercantileFederation,
    Subfaction.northernLightsConfederacy,
  ]),
  nuCoal('NuCoal', [
    Subfaction.nuCoalSelfDefenseForce,
    Subfaction.portArthurKorps,
    Subfaction.khayrAdDin,
    Subfaction.templeHeights,
    Subfaction.hardScrabbledCityStates,
  ]),
  peaceRiver('Peace River', [
    Subfaction.peaceRiverDefenseForce,
    Subfaction.peaceOfficerCorps,
    Subfaction.paxtonPrivateSecurities,
  ]),
  south('South', [
    Subfaction.southernRepublic,
    Subfaction.milicia,
    Subfaction.mekongDominion,
    Subfaction.easternSunEmirates,
    Subfaction.humanistAlliance,
  ]),
  utopia('Utopia', [
    Subfaction.unitedRepublicOfSteelgate,
    Subfaction.industrialStatesOfKogland,
    Subfaction.greenwayAlliance,
    Subfaction.independentStates,
    Subfaction.iAutoP,
  ]);

  final String displayName;
  final List<Subfaction> subfactions;

  const Faction(this.displayName, this.subfactions);
}
