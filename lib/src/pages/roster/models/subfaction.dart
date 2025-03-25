import 'package:gearforce/src/pages/roster/models/faction.dart';

enum Subfaction {
  // North
  norguard,
  westernFrontierProtectorate,
  unitedMercantileFederation,
  northernLightsConfederacy,

  // South
  southernRepublic,
  milicia,
  mekongDominion,
  easternSunEmirates,
  humanistAlliance,

  // NuCoal
  nuCoalSelfDefenseForce,
  portArthurKorps,
  khayrAdDin,
  templeHeights,
  hardScrabbledCityStates,

  // Peace River
  peaceRiverDefenseForce,
  peaceOfficerCorps,
  paxtonPrivateSecurities,

  // Black Talons
  talonReconTeam,
  talonInsertionTeam,
  talonAssaultTeam,
  talonStrikeTeam,

  // CEF
  expeditionaryForce,
  garrisonForce,
  earthAdministrationZone,
  rebelForce,

  // Caprice
  hakkarSecurity,
  costaMoreiaSecurity,
  corporatiSecurity,
  liberatiMilitia,

  // Utopia
  unitedRepublicOfSteelgate,
  industrialStatesOfKogland,
  greenwayAlliance,
  independentStates,
  iAutoP,

  // Eden
  seiathEmpire,
  auduuthKingdom,
  muratCorsairs,
  nobleShareholders,
  adHocKingdomOrConsortium,

  // New Jerusalem
  orderOfSaintMichael,
  orderOfSaintGeorge,
  orderOfSaintJoshua,
}

extension SubfactionExtension on Subfaction {
  String get displayName {
    switch (this) {
      // North
      case Subfaction.norguard:
        return 'Norguard (NG)';
      case Subfaction.westernFrontierProtectorate:
        return 'Western Frontier Protectorate (WP)';
      case Subfaction.unitedMercantileFederation:
        return 'United Mercantile Federation (UMF)';
      case Subfaction.northernLightsConfederacy:
        return 'Northern Lights Confederacy (NLC)';

      // South
      case Subfaction.southernRepublic:
        return 'Southern Republic (SR)';
      case Subfaction.milicia:
        return 'MILICIA';
      case Subfaction.mekongDominion:
        return 'Mekong Dominion (MD)';
      case Subfaction.easternSunEmirates:
        return 'Eastern Sun Emirates (ESE)';
      case Subfaction.humanistAlliance:
        return 'Humanist Alliance (HA)';

      // NuCoal
      case Subfaction.nuCoalSelfDefenseForce:
        return 'NuCoal Self Defense Force (NSDF)';
      case Subfaction.portArthurKorps:
        return 'Port Arthur Korps (PAK)';
      case Subfaction.khayrAdDin:
        return 'Khayr ad-Din (KAD)';
      case Subfaction.templeHeights:
        return 'Temple Heights (TH)';
      case Subfaction.hardScrabbledCityStates:
        return 'Hard Scrabbled City-States (HSCS)';

      // Peace River
      case Subfaction.peaceRiverDefenseForce:
        return 'Peace River Defense Force (PRDF)';
      case Subfaction.peaceOfficerCorps:
        return 'Peace Officer Corps (POC)';
      case Subfaction.paxtonPrivateSecurities:
        return 'Paxton Private Securities (PPS)';

      // Black Talons
      case Subfaction.talonReconTeam:
        return 'Talon Recon Team (TRT)';
      case Subfaction.talonInsertionTeam:
        return 'Talon Insertion Team (TIT)';
      case Subfaction.talonAssaultTeam:
        return 'Talon Assault Team (TAT)';
      case Subfaction.talonStrikeTeam:
        return 'Talon Strike Team (TST)';

      // CEF
      case Subfaction.expeditionaryForce:
        return 'Expeditionary Force (EF)';
      case Subfaction.garrisonForce:
        return 'Garrison Force (GF)';
      case Subfaction.earthAdministrationZone:
        return 'Earth Administration Zone (EAZ)';
      case Subfaction.rebelForce:
        return 'Rebel Force (RF)';

      // Caprice
      case Subfaction.hakkarSecurity:
        return 'Hakkar Security (HS)';
      case Subfaction.costaMoreiaSecurity:
        return 'Costa Moreia Security (CMS)';
      case Subfaction.corporatiSecurity:
        return 'Corporati Security (CS)';
      case Subfaction.liberatiMilitia:
        return 'Liberati Militia (LM)';

      // Utopia
      case Subfaction.unitedRepublicOfSteelgate:
        return 'United Republic of Steelgate (URS)';
      case Subfaction.industrialStatesOfKogland:
        return 'Industrial States Of Kogland (ISK)';
      case Subfaction.greenwayAlliance:
        return 'Greenway Alliance (GA)';
      case Subfaction.independentStates:
        return 'Independent States (IS)';
      case Subfaction.iAutoP:
        return 'I-Auto-P (IAP)';

      // Eden
      case Subfaction.seiathEmpire:
        return 'Seiath Empire (SE)';
      case Subfaction.auduuthKingdom:
        return 'Audu’uth Kingdom (AK)';
      case Subfaction.muratCorsairs:
        return 'Murat Corsairs (MC)';
      case Subfaction.nobleShareholders:
        return 'Noble Shareholders (NS)';
      case Subfaction.adHocKingdomOrConsortium:
        return 'Ad-Hoc Kingdom or Consortium (AHKC)';

      // New Jerusalem
      case Subfaction.orderOfSaintMichael:
        return 'Order of Saint Michael (OSM)';
      case Subfaction.orderOfSaintGeorge:
        return 'Order of Saint George (OSG)';
      case Subfaction.orderOfSaintJoshua:
        return 'Order of Saint Joshua (OSJ)';
    }
  }
}

extension FactionSubfactions on Faction {
  List<Subfaction> get subfactions {
    switch (this) {
      case Faction.north:
        return [
          Subfaction.norguard,
          Subfaction.westernFrontierProtectorate,
          Subfaction.unitedMercantileFederation,
          Subfaction.northernLightsConfederacy,
        ];
      case Faction.south:
        return [
          Subfaction.southernRepublic,
          Subfaction.milicia,
          Subfaction.mekongDominion,
          Subfaction.easternSunEmirates,
          Subfaction.humanistAlliance,
        ];
      case Faction.nuCoal:
        return [
          Subfaction.nuCoalSelfDefenseForce,
          Subfaction.portArthurKorps,
          Subfaction.khayrAdDin,
          Subfaction.templeHeights,
          Subfaction.hardScrabbledCityStates,
        ];
      case Faction.peaceRiver:
        return [
          Subfaction.peaceRiverDefenseForce,
          Subfaction.peaceOfficerCorps,
          Subfaction.paxtonPrivateSecurities,
        ];
      case Faction.blackTalons:
        return [
          Subfaction.talonReconTeam,
          Subfaction.talonInsertionTeam,
          Subfaction.talonAssaultTeam,
          Subfaction.talonStrikeTeam,
        ];
      case Faction.cef:
        return [
          Subfaction.expeditionaryForce,
          Subfaction.garrisonForce,
          Subfaction.earthAdministrationZone,
          Subfaction.rebelForce,
        ];
      case Faction.caprice:
        return [
          Subfaction.hakkarSecurity,
          Subfaction.costaMoreiaSecurity,
          Subfaction.corporatiSecurity,
          Subfaction.liberatiMilitia,
        ];
      case Faction.utopia:
        return [
          Subfaction.unitedRepublicOfSteelgate,
          Subfaction.industrialStatesOfKogland,
          Subfaction.greenwayAlliance,
          Subfaction.independentStates,
          Subfaction.iAutoP,
        ];
      case Faction.eden:
        return [
          Subfaction.seiathEmpire,
          Subfaction.auduuthKingdom,
          Subfaction.muratCorsairs,
          Subfaction.nobleShareholders,
          Subfaction.adHocKingdomOrConsortium,
        ];
    }
  }
}
