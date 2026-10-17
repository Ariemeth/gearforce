import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';
import 'package:meta/meta.dart';

@immutable
class SquadUpgradesRule extends Rule {
  final List<SquadUpgrade> availableUpgrades;

  static const SquadUpgradesRule standard = SquadUpgradesRule(
    availableUpgrades: SquadUpgrade.allUpgrades,
  );

  const SquadUpgradesRule({
    super.name = 'Squad Upgrades Rule',
    super.id = 'squad-upgrades-rule',
    super.description = 'Defines which squad-level upgrades are available.',
    super.isEnabled = true,
    super.canBeToggled = false,
    super.requirementCheck,
    required this.availableUpgrades,
  });
}
