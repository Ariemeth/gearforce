import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/static/squad_upgrades.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';

void main() {
  group('SquadUpgrades', () {
    test('contains the expected standard squad upgrades', () {
      final upgrades = SquadUpgrades.standard;

      expect(upgrades.length, 7);
      expect(upgrades.map((upgrade) => upgrade.id), [
        'squad-grenades-light',
        'squad-grenades-medium',
        'squad-panzerfausts-light',
        'squad-panzerfausts-medium',
        'squad-shaped-explosives-light',
        'squad-shaped-explosives-medium',
        'squad-sidearms',
      ]);
    });

    test('marks sidearms as a react-column upgrade', () {
      expect(SquadUpgrades.sidearms.column, SquadUpgradeColumn.react);
      expect(SquadUpgrades.sidearms.weaponCode, 'LP');
      expect(SquadUpgrades.sidearms.tv, 1);
    });
  });
}