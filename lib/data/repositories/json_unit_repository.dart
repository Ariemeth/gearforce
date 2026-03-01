import 'dart:convert';
import 'dart:developer' as developer;
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';

class JsonUnitRepository implements UnitRepository {
  final Map<Faction, List<Unit>> _cache = {};
  final Map<String, Unit> _unitIdCache = {};

  @override
  Future<List<Unit>> getUnitsByFaction(Faction faction) async {
    if (_cache.containsKey(faction)) {
      return _cache[faction]!;
    }

    try {
      final fileName = faction.name.toLowerCase();
      final String jsonString = await rootBundle.loadString(
        'assets/data/units/$fileName.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString) as List<dynamic>;

      final List<Unit> units = [];
      for (int i = 0; i < jsonData.length; i++) {
        try {
          final unit = parseUnit(jsonData[i] as Map<String, dynamic>);
          units.add(unit);
        } catch (itemError) {
          final unitData = jsonData[i];
          final unitId = unitData is Map
              ? unitData['id'] ?? 'UNKNOWN'
              : 'NOT_A_MAP';
          developer.log(
            'Error parsing unit $unitId (index $i) from $fileName.json: $itemError\nData: $unitData',
            name: 'JsonUnitRepository',
            error: itemError,
          );
          rethrow;
        }
      }

      _cache[faction] = units;

      // Cache by unit ID for quick lookup
      for (final unit in units) {
        _unitIdCache[unit.id] = unit;
      }

      return units;
    } catch (e) {
      developer.log(
        'Error loading units for ${faction.name} (file: ${faction.name.toLowerCase()}.json): $e',
        name: 'JsonUnitRepository',
        error: e,
      );
      rethrow;
    }
  }

  @override
  Future<Unit?> getUnitById(String unitId) async {
    // Check if already cached by ID
    if (_unitIdCache.containsKey(unitId)) {
      return _unitIdCache[unitId];
    }

    // If not cached, load all factions and search
    try {
      for (final faction in Faction.values) {
        final units = await getUnitsByFaction(faction);
        final unit = units.firstWhere(
          (u) => u.id == unitId,
          orElse: () => throw StateError('Unit not found'),
        );
        return unit;
      }
      return null;
    } catch (e) {
      developer.log(
        'Error loading unit with ID $unitId: $e',
        name: 'JsonUnitRepository',
        error: e,
      );
      return null;
    }
  }

  @visibleForTesting
  Unit parseUnit(Map<String, dynamic> data) {
    return Unit.fromJson(data);
  }
}
