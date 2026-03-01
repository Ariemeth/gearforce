import 'package:gearforce/domain/entities/equipment/weapon.dart' show Weapon;
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';
import 'package:meta/meta.dart';

@immutable
class SquadUpgrade {
  final String id;
  final String name;
  final UpgradeType type;
  final int tv;
  final String description;
  final List<WeaponSpec> weaponsToAdd;

  const SquadUpgrade({
    required this.id,
    required this.name,
    required this.type,
    required this.tv,
    required this.description,
    this.weaponsToAdd = const [],
  });

  SquadUpgrade copyWith({
    String? id,
    String? name,
    UpgradeType? type,
    int? tv,
    String? description,
    List<WeaponSpec>? weaponsToAdd,
  }) {
    return SquadUpgrade(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      tv: tv ?? this.tv,
      description: description ?? this.description,
      weaponsToAdd: weaponsToAdd ?? this.weaponsToAdd,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SquadUpgrade && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // Available squad upgrades
  static const grenadesLight = SquadUpgrade(
    id: 'squad-grenades-light',
    name: 'Grenades - Light',
    type: UpgradeType.squad,
    tv: 1,
    description: 'All Gears in 1 Squad may add an LHG to the Mounted Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.hg(WeaponSize.light))],
  );

  static const grenadesMedium = SquadUpgrade(
    id: 'squad-grenades-medium',
    name: 'Grenades - Medium',
    type: UpgradeType.squad,
    tv: 2,
    description: 'All Gears in 1 Squad may add an MHG to the Mounted Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.hg(WeaponSize.medium))],
  );

  static const panzerfaustsLight = SquadUpgrade(
    id: 'squad-panzerfausts-light',
    name: 'Panzerfausts - Light',
    type: UpgradeType.squad,
    tv: 1,
    description: 'All Gears in 1 Squad may add an LPZ to the Mounted Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.pz(WeaponSize.light))],
  );

  static const panzerfaustsMedium = SquadUpgrade(
    id: 'squad-panzerfausts-medium',
    name: 'Panzerfausts - Medium',
    type: UpgradeType.squad,
    tv: 2,
    description: 'All Gears in 1 Squad may add an MPZ to the Mounted Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.pz(WeaponSize.medium))],
  );

  static const shapedExplosivesLight = SquadUpgrade(
    id: 'squad-shaped-explosives-light',
    name: 'Shaped Explosives - Light',
    type: UpgradeType.squad,
    tv: 1,
    description: 'All Gears in 1 Squad may add an LSE to the Mounted Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.se(WeaponSize.light))],
  );

  static const shapedExplosivesMedium = SquadUpgrade(
    id: 'squad-shaped-explosives-medium',
    name: 'Shaped Explosives - Medium',
    type: UpgradeType.squad,
    tv: 2,
    description: 'All Gears in 1 Squad may add an MSE to the Mounted Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.se(WeaponSize.medium))],
  );

  static const sidearms = SquadUpgrade(
    id: 'squad-sidearms',
    name: 'Sidearms',
    type: UpgradeType.squad,
    tv: 1,
    description: 'All Gears in 1 Squad may add an LP to the React Column.',
    weaponsToAdd: [SingleWeaponSpec(weapon: Weapon.p(WeaponSize.light))],
  );

  // List of all available squad upgrades
  static const allUpgrades = [
    grenadesLight,
    grenadesMedium,
    panzerfaustsLight,
    panzerfaustsMedium,
    shapedExplosivesLight,
    shapedExplosivesMedium,
    sidearms,
  ];
}
