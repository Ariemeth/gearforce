// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/repositories/json_unit_repository.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Unit JSON Loading Benchmarks', () {
    late JsonUnitRepository unitRepository;

    setUp(() {
      unitRepository = JsonUnitRepository();
    });

    test('benchmark: load and parse north units via repository', () async {
      // Benchmark: Repository async loading (cold load)
      final stopwatch = Stopwatch()..start();
      final units = await unitRepository.getUnitsByFaction(Faction.north);
      stopwatch.stop();

      print('\n=== North Faction Repository Loading ===');
      print('Unit count: ${units.length}');
      print('Total load time: ${stopwatch.elapsedMilliseconds}ms');
      print(
        'Average time per unit: ${(stopwatch.elapsedMilliseconds / units.length).toStringAsFixed(2)}ms',
      );

      // Benchmark: Cache hit (second call should be instant)
      final cacheStopwatch = Stopwatch()..start();
      final cachedUnits = await unitRepository.getUnitsByFaction(Faction.north);
      cacheStopwatch.stop();

      print('Cache hit time: ${cacheStopwatch.elapsedMilliseconds}ms');
      final improvement =
          stopwatch.elapsedMilliseconds ~/
          (cacheStopwatch.elapsedMilliseconds + 1);
      print('Cache performance improvement: ${improvement}x faster');

      // Show unit details
      if (units.isNotEmpty) {
        final firstUnit = units.first;
        print('\nFirst unit: ${firstUnit.name}');
        print('  - Variants: ${firstUnit.variants.length}');
        print('  - Upgrades: ${firstUnit.availableProfileUpgrades.length}');
        if (firstUnit.base.reactWeapons.isNotEmpty) {
          print('  - React weapons: ${firstUnit.base.reactWeapons.length}');
        }
        if (firstUnit.base.mountedWeapons.isNotEmpty) {
          print('  - Mounted weapons: ${firstUnit.base.mountedWeapons.length}');
        }
      }

      expect(units, isNotEmpty);
      expect(cachedUnits.length, units.length);
    });

    test('benchmark: load and parse black talons units via repository', () async {
      // Benchmark: Repository async loading
      final stopwatch = Stopwatch()..start();
      final units = await unitRepository.getUnitsByFaction(Faction.blackTalons);
      stopwatch.stop();

      if (units.isEmpty) {
        print('Black Talons unit file not available');
        return;
      }

      print('\n=== Black Talons Faction Repository Loading ===');
      print('Unit count: ${units.length}');
      print('Total load time: ${stopwatch.elapsedMilliseconds}ms');
      print(
        'Average time per unit: ${(stopwatch.elapsedMilliseconds / units.length).toStringAsFixed(2)}ms',
      );

      expect(units, isNotEmpty);
    });

    test('benchmark: analyze unit characteristics', () async {
      final units = await unitRepository.getUnitsByFaction(Faction.north);

      if (units.isEmpty) {
        print('No units available for analysis');
        return;
      }

      final unitsWithVariants = units.where((u) => u.variants.isNotEmpty);
      final unitsWithUpgrades = units.where(
        (u) => u.availableProfileUpgrades.isNotEmpty,
      );
      final unitsWithWeapons = units.where(
        (u) =>
            u.base.reactWeapons.isNotEmpty || u.base.mountedWeapons.isNotEmpty,
      );

      print('\n=== Unit Characteristics Analysis ===');
      print('Total units: ${units.length}');
      print('Units with variants: ${unitsWithVariants.length}');
      print('Units with upgrades: ${unitsWithUpgrades.length}');
      print('Units with weapons: ${unitsWithWeapons.length}');

      // Show sample complex units
      final complexUnits = units.where(
        (u) => u.variants.isNotEmpty && u.availableProfileUpgrades.isNotEmpty,
      );

      if (complexUnits.isNotEmpty) {
        print('\nSample complex units (with variants and upgrades):');
        for (final unit in complexUnits.take(3)) {
          print(
            '  ${unit.name}: ${unit.variants.length} variants, ${unit.availableProfileUpgrades.length} upgrades',
          );
        }
      }

      expect(units, isNotEmpty);
    });

    test('benchmark: compare first load vs cached load', () async {
      // Clear any previous cache by creating a new repository
      final repo1 = JsonUnitRepository();

      final firstLoadStopwatch = Stopwatch()..start();
      final firstLoad = await repo1.getUnitsByFaction(Faction.north);
      firstLoadStopwatch.stop();

      final cachedLoadStopwatch = Stopwatch()..start();
      final cachedLoad = await repo1.getUnitsByFaction(Faction.north);
      cachedLoadStopwatch.stop();

      print('\n=== Load Performance Comparison ===');
      print('First load time: ${firstLoadStopwatch.elapsedMilliseconds}ms');
      print('Cached load time: ${cachedLoadStopwatch.elapsedMilliseconds}ms');
      final improvement =
          firstLoadStopwatch.elapsedMilliseconds ~/
          (cachedLoadStopwatch.elapsedMilliseconds + 1);
      print('Cache speedup: ${improvement}x faster');
      print('Units loaded: ${firstLoad.length}');

      expect(firstLoad, isNotEmpty);
      expect(cachedLoad.length, firstLoad.length);
    });
  });
}
