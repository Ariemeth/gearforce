import 'package:gearforce/domain/entities/faction/subfaction.dart';

enum Faction {
  blackTalons('Black Talon', 'F1', [
    Subfaction.talonDefault,
    Subfaction.talonReconTeam,
    Subfaction.talonInsertionTeam,
    Subfaction.talonAssaultTeam,
    Subfaction.talonStrikeTeam,
  ]),
  cef('CEF', 'F2', [
    Subfaction.cefDefault,
    Subfaction.expeditionaryForce,
    Subfaction.garrisonForce,
    Subfaction.earthAdministrationZone,
    Subfaction.rebelForce,
  ]),
  caprice('Caprice', 'F3', [
    Subfaction.capriceDefault,
    Subfaction.hakkarSecurity,
    Subfaction.costaMoreiaSecurity,
    Subfaction.corporatiSecurity,
    Subfaction.liberatiMilitia,
  ]),
  eden('Eden', 'F4', [
    Subfaction.edenDefault,
    Subfaction.seiathEmpire,
    Subfaction.auduuthKingdom,
    Subfaction.muratCorsairs,
    Subfaction.nobleShareholders,
    Subfaction.adHocKingdomOrConsortium,
  ]),
  north('North', 'F5', [
    Subfaction.northDefault,
    Subfaction.norguard,
    Subfaction.westernFrontierProtectorate,
    Subfaction.unitedMercantileFederation,
    Subfaction.northernLightsConfederacy,
  ]),
  nuCoal('NuCoal', 'F6', [
    Subfaction.nuCoalDefault,
    Subfaction.nuCoalSelfDefenseForce,
    Subfaction.portArthurKorps,
    Subfaction.khayrAdDin,
    Subfaction.templeHeights,
    Subfaction.hardScrabbledCityStates,
  ]),
  peaceRiver('Peace River', 'F7', [
    Subfaction.peaceRiverDefault,
    Subfaction.peaceRiverDefenseForce,
    Subfaction.peaceOfficerCorps,
    Subfaction.paxtonPrivateSecurities,
  ]),
  south('South', 'F8', [
    Subfaction.southDefault,
    Subfaction.southernRepublic,
    Subfaction.milicia,
    Subfaction.mekongDominion,
    Subfaction.easternSunEmirates,
    Subfaction.humanistAlliance,
  ]),
  utopia('Utopia', 'F9', [
    Subfaction.utopiaDefault,
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
