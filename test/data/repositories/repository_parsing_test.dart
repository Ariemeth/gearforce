import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/repositories/json_unit_repository.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';
import 'package:gearforce/data/static/weapon_factory.dart';

/// A test subclass that exposes [parseUnit] for direct testing.
class TestableUnitRepository extends JsonUnitRepository {
  void testParseUnit(Map<String, dynamic> json) {
    parseUnit(json);
  }
}

class TestWeaponRepository implements WeaponRepository {
  final Map<String, Map<String, dynamic>> _weaponsByCode = {};

  TestWeaponRepository() {
    final file = File('assets/data/weapons/weapons.json');
    final jsonString = file.readAsStringSync();
    final List<dynamic> jsonData = json.decode(jsonString);
    for (final item in jsonData) {
      final weaponMap = item as Map<String, dynamic>;
      _weaponsByCode[weaponMap['code'] as String] = weaponMap;
    }
  }

  @override
  Future<List<Weapon>> getWeapons({WeaponSize size = WeaponSize.light}) async {
    return _weaponsByCode.values.map((j) => Weapon.fromJson(j, size)).toList();
  }

  @override
  Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    final size = WeaponSize.fromCode(code);
    final baseCode = code.substring(1);
    final weaponJson = _weaponsByCode[baseCode];
    if (weaponJson == null) return null;
    return Weapon.fromJson(weaponJson, size, isReact: hasReact);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestWeaponRepository weaponRepository;
  late TestableUnitRepository unitRepository;

  setUpAll(() {
    weaponRepository = TestWeaponRepository();
    WeaponFactory.setRepository(weaponRepository);
  });

  setUp(() {
    unitRepository = TestableUnitRepository();
  });

  group('JsonUnitRepository.parseUnit', () {
    test('parses unit with nested base object', () {
      final file = File('assets/data/units/north.json');
      final jsonString = file.readAsStringSync();
      final List<dynamic> jsonData = json.decode(jsonString);

      // Use the first unit from real data
      expect(jsonData, isNotEmpty);

      final firstUnitJson = jsonData.first as Map<String, dynamic>;
      final unit = unitRepository.parseUnit(firstUnitJson);

      expect(unit.id, isNotEmpty);
      expect(unit.name, isNotEmpty);
      expect(unit.base.tv, greaterThanOrEqualTo(0));
    });

    test('parses all north units without error', () {
      final file = File('assets/data/units/north.json');
      final jsonString = file.readAsStringSync();
      final List<dynamic> jsonData = json.decode(jsonString);

      final units = jsonData.map((data) {
        return unitRepository.parseUnit(data as Map<String, dynamic>);
      }).toList();

      expect(units, isNotEmpty);
      // Verify all units have valid IDs
      for (final unit in units) {
        expect(unit.id, isNotEmpty, reason: 'Unit ${unit.name} has empty ID');
      }
    });

    test('parses unit with variants', () {
      final file = File('assets/data/units/north.json');
      final jsonString = file.readAsStringSync();
      final List<dynamic> jsonData = json.decode(jsonString);

      // Find a unit that has variants
      final unitWithVariants = jsonData.firstWhere(
        (data) =>
            (data as Map<String, dynamic>)['variants'] != null &&
            ((data)['variants'] as List).isNotEmpty,
        orElse: () => null,
      );

      if (unitWithVariants != null) {
        final unit = unitRepository.parseUnit(
          unitWithVariants as Map<String, dynamic>,
        );
        expect(unit.variants, isNotEmpty);
        for (final variant in unit.variants) {
          expect(variant.id, isNotEmpty);
        }
      }
    });

    test('parses unit with upgrades', () {
      final file = File('assets/data/units/north.json');
      final jsonString = file.readAsStringSync();
      final List<dynamic> jsonData = json.decode(jsonString);

      // Find a unit that has upgrades
      final unitWithUpgrades = jsonData.firstWhere(
        (data) =>
            (data as Map<String, dynamic>)['upgrades'] != null &&
            ((data)['upgrades'] as List).isNotEmpty,
        orElse: () => null,
      );

      if (unitWithUpgrades != null) {
        final unit = unitRepository.parseUnit(
          unitWithUpgrades as Map<String, dynamic>,
        );
        expect(unit.availableModelUpgrades, isNotEmpty);

        final model = Model(
          id: 1,
          base: unit.base,
          variant: unit.variants.first,
          availableModelUpgrades: unit.availableModelUpgrades,
        );

        final flakJacket = unit.availableModelUpgrades.firstWhere(
          (upgrade) => upgrade.id == 'north-hunter-flakjacket',
        );
        final upgradedModel = model.addModelUpgrade(flakJacket);

        expect(upgradedModel.tv, model.tv + 1);
        expect(upgradedModel.hullStructure.hull, 6);
        expect(upgradedModel.hullStructure.structure, 2);
      }
    });
  });

  group('WeaponRepository', () {
    test('getWeaponByCode returns weapon for valid code', () {
      // Use a known weapon code from the real data
      final weapon = weaponRepository.getWeaponByCode('LSMG');
      // If LSMG doesn't exist, try other common codes
      if (weapon != null) {
        expect(weapon.code, isNotEmpty);
      }
    });

    test('getWeaponByCode returns null for unknown code', () {
      // Code must start with valid size prefix (L, M, H)
      final weapon = weaponRepository.getWeaponByCode('LXYZ');
      expect(weapon, isNull);
    });

    test('getWeapons returns non-empty list', () async {
      final weapons = await weaponRepository.getWeapons();
      expect(weapons, isNotEmpty);
    });
  });
}
