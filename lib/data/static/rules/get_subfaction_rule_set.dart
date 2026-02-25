import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/blackTalons/black_talon_rule_set.dart';
import 'package:gearforce/data/static/rules/default_rule_set.dart';
import 'package:gearforce/data/static/rules/north/north_rule_set.dart';

/// Factory to generate a RuleSet for a given subfaction.
/// Defaults all subfactions to the DefaultRuleSet.
RuleSet getSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  switch (subfaction) {
    // North subfactions.
    case Subfaction.northDefault:
      return NorthRuleSet(unitRepository);
    case Subfaction.norguard:
    case Subfaction.westernFrontierProtectorate:
    case Subfaction.unitedMercantileFederation:
    case Subfaction.northernLightsConfederacy:
    // South subfactions.
    case Subfaction.southDefault:
    case Subfaction.southernRepublic:
    case Subfaction.milicia:
    case Subfaction.mekongDominion:
    case Subfaction.easternSunEmirates:
    case Subfaction.humanistAlliance:
    // NuCoal subfactions.
    case Subfaction.nuCoalDefault:
    case Subfaction.nuCoalSelfDefenseForce:
    case Subfaction.portArthurKorps:
    case Subfaction.khayrAdDin:
    case Subfaction.templeHeights:
    case Subfaction.hardScrabbledCityStates:
    // Peace River subfactions.
    case Subfaction.peaceRiverDefault:
    case Subfaction.peaceRiverDefenseForce:
    case Subfaction.peaceOfficerCorps:
    case Subfaction.paxtonPrivateSecurities:
    // Black Talon subfactions.
    case Subfaction.talonDefault:
      return BlackTalonRuleSet(unitRepository);
    case Subfaction.talonReconTeam:
    case Subfaction.talonInsertionTeam:
    case Subfaction.talonAssaultTeam:
    case Subfaction.talonStrikeTeam:
    // CEF subfactions.
    case Subfaction.cefDefault:
    case Subfaction.expeditionaryForce:
    case Subfaction.garrisonForce:
    case Subfaction.earthAdministrationZone:
    case Subfaction.rebelForce:
    // Caprice subfactions.
    case Subfaction.capriceDefault:
    case Subfaction.hakkarSecurity:
    case Subfaction.costaMoreiaSecurity:
    case Subfaction.corporatiSecurity:
    case Subfaction.liberatiMilitia:
    // Utopia subfactions.
    case Subfaction.utopiaDefault:
    case Subfaction.unitedRepublicOfSteelgate:
    case Subfaction.industrialStatesOfKogland:
    case Subfaction.greenwayAlliance:
    case Subfaction.independentStates:
    case Subfaction.iAutoP:
    // Eden subfactions.
    case Subfaction.edenDefault:
    case Subfaction.seiathEmpire:
    case Subfaction.auduuthKingdom:
    case Subfaction.muratCorsairs:
    case Subfaction.nobleShareholders:
    case Subfaction.adHocKingdomOrConsortium:
    // New Jerusalem subfactions.
    case Subfaction.newJerusalemDefault:
    case Subfaction.orderOfSaintMichael:
    case Subfaction.orderOfSaintGeorge:
    case Subfaction.orderOfSaintJoshua:
      return DefaultRuleSet();
  }
}
