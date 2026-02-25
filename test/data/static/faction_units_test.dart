import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/repositories/json_unit_repository.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';
import 'package:gearforce/data/static/weapon_factory.dart';

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
  Future<List<Weapon>> getWeapons() async {
    return _weaponsByCode.values
        .map((json) => Weapon.fromJson(json, WeaponSize.light))
        .toList();
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

class TestJsonUnitRepository extends JsonUnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(String factionId) async {
    final file = File('assets/data/units/${factionId.toLowerCase()}.json');
    if (!file.existsSync()) return [];
    final jsonString = await file.readAsString();
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => parseUnitForTest(data)).toList();
  }

  Unit parseUnitForTest(Map<String, dynamic> data) {
    return super.parseUnit(data);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final weaponRepository = TestWeaponRepository();
  WeaponFactory.setRepository(weaponRepository);

  final factions = ['north', 'blacktalons'];

  for (final faction in factions) {
    group('$faction Units', () {
      test(
        'should have unique IDs for all units, upgrades, and variants',
        () async {
          final repository = TestJsonUnitRepository();
          final units = await repository.getUnitsByFaction(faction);

          expect(units.isNotEmpty, true, reason: 'No units found for $faction');

          // Check that all unit IDs are unique
          final unitIds = units.map((unit) => unit.id).toList();
          final duplicateUnitIds = unitIds
              .where((id) => unitIds.where((x) => x == id).length > 1)
              .toSet();
          expect(
            duplicateUnitIds.isEmpty,
            true,
            reason: 'Duplicate Unit IDs found in $faction: $duplicateUnitIds',
          );

          for (final unit in units) {
            // Check that all variant IDs within a unit are unique
            final variantIds = unit.variants
                .map((variant) => variant.id)
                .toList();
            final duplicateVariantIds = variantIds
                .where((id) => variantIds.where((x) => x == id).length > 1)
                .toSet();
            expect(
              duplicateVariantIds.isEmpty,
              true,
              reason:
                  'Duplicate Variant IDs for unit "${unit.name}" in $faction found: $duplicateVariantIds',
            );

            // Check that all upgrade IDs within a unit are unique
            final upgradeIds = unit.upgrades
                .map((upgrade) => upgrade.id)
                .toList();
            final duplicateUpgradeIds = upgradeIds
                .where((id) => upgradeIds.where((x) => x == id).length > 1)
                .toSet();
            expect(
              duplicateUpgradeIds.isEmpty,
              true,
              reason:
                  'Duplicate Upgrade IDs for unit "${unit.name}" in $faction found: $duplicateUpgradeIds',
            );
          }
        },
      );
    });
  }
}
