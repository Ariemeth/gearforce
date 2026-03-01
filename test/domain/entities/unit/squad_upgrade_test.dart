import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';

void main() {
  group('SquadUpgrade', () {
    test('grenadesLight should have correct properties', () {
      // Act
      const upgrade = SquadUpgrade.grenadesLight;

      // Assert
      expect(upgrade.id, 'squad-grenades-light');
      expect(upgrade.name, 'Grenades - Light');
      expect(upgrade.type, UpgradeType.squad);
      expect(upgrade.tv, 1);
      expect(
        upgrade.description,
        'All Gears in 1 Squad may add an LHG to the Mounted Column.',
      );
      expect(upgrade.weaponsToAdd.length, 1);
    });

    test('grenadesMedium should have correct properties', () {
      // Act
      const upgrade = SquadUpgrade.grenadesMedium;

      // Assert
      expect(upgrade.id, 'squad-grenades-medium');
      expect(upgrade.name, 'Grenades - Medium');
      expect(upgrade.tv, 2);
    });

    test('allUpgrades should return all 7 upgrades', () {
      // Act
      const upgrades = SquadUpgrade.allUpgrades;

      // Assert
      expect(upgrades.length, 7);
      expect(
        upgrades.map((u) => u.id),
        containsAll([
          'squad-grenades-light',
          'squad-grenades-medium',
          'squad-panzerfausts-light',
          'squad-panzerfausts-medium',
          'squad-shaped-explosives-light',
          'squad-shaped-explosives-medium',
          'squad-sidearms',
        ]),
      );
    });

    test('should create copy with updated fields', () {
      // Arrange
      const upgrade = SquadUpgrade.sidearms;

      // Act
      final updated = upgrade.copyWith(name: 'Updated', tv: 2);

      // Assert
      expect(updated.name, 'Updated');
      expect(updated.tv, 2);
      expect(updated.id, 'squad-sidearms');
      expect(updated.type, UpgradeType.squad);
    });

    test('should compare upgrades by id', () {
      // Arrange
      const upgrade1 = SquadUpgrade.grenadesLight;
      const upgrade2 = SquadUpgrade.grenadesLight;
      const upgrade3 = SquadUpgrade.grenadesMedium;

      // Assert
      expect(upgrade1, equals(upgrade2));
      expect(identical(upgrade1, upgrade2), isTrue); // Same instance
      expect(upgrade1, isNot(equals(upgrade3)));
    });

    test('should be singleton instances', () {
      // Verify that accessing the same upgrade returns the same instance
      const first = SquadUpgrade.grenadesLight;
      const second = SquadUpgrade.grenadesLight;

      // Assert
      expect(identical(first, second), isTrue);
    });
  });
}
