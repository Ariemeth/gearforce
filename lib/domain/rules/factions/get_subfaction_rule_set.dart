import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/black_talons/black_talon_rule_set.dart';
import 'package:gearforce/domain/rules/factions/caprice/caprice_rule_set.dart';
import 'package:gearforce/domain/rules/factions/cef/cef_rule_set.dart';
import 'package:gearforce/domain/rules/factions/eden/eden_rule_set.dart';
import 'package:gearforce/domain/rules/factions/north/north_rule_set.dart';
import 'package:gearforce/domain/rules/factions/nucoal/nucoal_rule_set.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/peaceriver_rule_set.dart';
import 'package:gearforce/domain/rules/factions/south/south_rule_set.dart';
import 'package:gearforce/domain/rules/factions/utopia/utopia_rule_set.dart';

/// Factory to generate a RuleSet for a given subfaction.
/// Delegates lookup to the appropriate faction-level subfaction factory.
RuleSet getSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  final faction = Faction.values.firstWhere(
    (f) => f.subfactions.contains(subfaction),
    orElse: () => Faction.north,
  );

  return switch (faction) {
    Faction.north => getNorthSubfactionRuleSet(subfaction, unitRepository),
    Faction.south => getSouthSubfactionRuleSet(subfaction, unitRepository),
    Faction.nuCoal => getNuCoalSubfactionRuleSet(subfaction, unitRepository),
    Faction.peaceRiver => getPeaceRiverSubfactionRuleSet(
      subfaction,
      unitRepository,
    ),
    Faction.blackTalons => getBlackTalonSubfactionRuleSet(
      subfaction,
      unitRepository,
    ),
    Faction.cef => getCefSubfactionRuleSet(subfaction, unitRepository),
    Faction.caprice => getCapriceSubfactionRuleSet(subfaction, unitRepository),
    Faction.utopia => getUtopiaSubfactionRuleSet(subfaction, unitRepository),
    Faction.eden => getEdenSubfactionRuleSet(subfaction, unitRepository),
  };
}
