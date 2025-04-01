import 'package:gearforce/src/models/roster/subfaction.dart';

enum Faction {
  blackTalons('Black Talons', 'F1', [
    Subfaction.talonReconTeam,
    Subfaction.talonInsertionTeam,
    Subfaction.talonAssaultTeam,
    Subfaction.talonStrikeTeam,
  ]),
  cef('CEF', 'F2', [
    Subfaction.expeditionaryForce,
    Subfaction.garrisonForce,
    Subfaction.earthAdministrationZone,
    Subfaction.rebelForce,
  ]),
  caprice('Caprice', 'F3', [
    Subfaction.hakkarSecurity,
    Subfaction.costaMoreiaSecurity,
    Subfaction.corporatiSecurity,
    Subfaction.liberatiMilitia,
  ]),
  eden('Eden', 'F4', [
    Subfaction.seiathEmpire,
    Subfaction.auduuthKingdom,
    Subfaction.muratCorsairs,
    Subfaction.nobleShareholders,
    Subfaction.adHocKingdomOrConsortium,
  ]),
  north('North', 'F5', [
    Subfaction.norguard,
    Subfaction.westernFrontierProtectorate,
    Subfaction.unitedMercantileFederation,
    Subfaction.northernLightsConfederacy,
  ]),
  nuCoal('NuCoal', 'F6', [
    Subfaction.nuCoalSelfDefenseForce,
    Subfaction.portArthurKorps,
    Subfaction.khayrAdDin,
    Subfaction.templeHeights,
    Subfaction.hardScrabbledCityStates,
  ]),
  peaceRiver('Peace River', 'F7', [
    Subfaction.peaceRiverDefenseForce,
    Subfaction.peaceOfficerCorps,
    Subfaction.paxtonPrivateSecurities,
  ]),
  south('South', 'F8', [
    Subfaction.southernRepublic,
    Subfaction.milicia,
    Subfaction.mekongDominion,
    Subfaction.easternSunEmirates,
    Subfaction.humanistAlliance,
  ]),
  utopia('Utopia', 'F9', [
    Subfaction.unitedRepublicOfSteelgate,
    Subfaction.industrialStatesOfKogland,
    Subfaction.greenwayAlliance,
    Subfaction.independentStates,
    Subfaction.iAutoP,
  ]);

  final String displayName;
  final List<Subfaction> subfactions;
  final String id;

  const Faction(this.displayName, this.id, this.subfactions);
}
