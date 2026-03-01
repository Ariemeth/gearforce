import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';

class SquadUpgrades {
  static const SquadUpgrade grenadesLight = SquadUpgrade(
    id: 'squad-grenades-light',
    name: 'Grenades - Light',
    tv: 1,
    description: 'All Gears in 1 Squad may add an LHG to the Mounted Column.',
    weaponCode: 'LHG',
    column: SquadUpgradeColumn.mounted,
  );

  static const SquadUpgrade grenadesMedium = SquadUpgrade(
    id: 'squad-grenades-medium',
    name: 'Grenades - Medium',
    tv: 2,
    description: 'All Gears in 1 Squad may add an MHG to the Mounted Column.',
    weaponCode: 'MHG',
    column: SquadUpgradeColumn.mounted,
  );

  static const SquadUpgrade panzerfaustsLight = SquadUpgrade(
    id: 'squad-panzerfausts-light',
    name: 'Panzerfausts - Light',
    tv: 1,
    description: 'All Gears in 1 Squad may add an LPZ to the Mounted Column.',
    weaponCode: 'LPZ',
    column: SquadUpgradeColumn.mounted,
  );

  static const SquadUpgrade panzerfaustsMedium = SquadUpgrade(
    id: 'squad-panzerfausts-medium',
    name: 'Panzerfausts - Medium',
    tv: 2,
    description: 'All Gears in 1 Squad may add an MPZ to the Mounted Column.',
    weaponCode: 'MPZ',
    column: SquadUpgradeColumn.mounted,
  );

  static const SquadUpgrade shapedExplosivesLight = SquadUpgrade(
    id: 'squad-shaped-explosives-light',
    name: 'Shaped Explosives - Light',
    tv: 1,
    description: 'All Gears in 1 Squad may add an LSE to the Mounted Column.',
    weaponCode: 'LSE',
    column: SquadUpgradeColumn.mounted,
  );

  static const SquadUpgrade shapedExplosivesMedium = SquadUpgrade(
    id: 'squad-shaped-explosives-medium',
    name: 'Shaped Explosives - Medium',
    tv: 2,
    description: 'All Gears in 1 Squad may add an MSE to the Mounted Column.',
    weaponCode: 'MSE',
    column: SquadUpgradeColumn.mounted,
  );

  static const SquadUpgrade sidearms = SquadUpgrade(
    id: 'squad-sidearms',
    name: 'Sidearms',
    tv: 1,
    description: 'All Gears in 1 Squad may add an LP to the React Column.',
    weaponCode: 'LP',
    column: SquadUpgradeColumn.react,
  );

  static const List<SquadUpgrade> standard = [
    grenadesLight,
    grenadesMedium,
    panzerfaustsLight,
    panzerfaustsMedium,
    shapedExplosivesLight,
    shapedExplosivesMedium,
    sidearms,
  ];
}