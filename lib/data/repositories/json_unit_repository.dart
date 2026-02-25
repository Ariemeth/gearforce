import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';

class JsonUnitRepository implements UnitRepository {
  final Map<String, List<Unit>> _cache = {};

  @override
  Future<List<Unit>> getUnitsByFaction(String factionId) async {
    final lowerFactionId = factionId.toLowerCase();
    if (_cache.containsKey(lowerFactionId)) {
      return _cache[lowerFactionId]!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/units/$lowerFactionId.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      final List<Unit> units = jsonData.map((data) => parseUnit(data)).toList();
      _cache[lowerFactionId] = units;
      return units;
    } catch (e) {
      print('Error loading units for $factionId: $e');
      return [];
    }
  }

  @visibleForTesting
  Unit parseUnit(Map<String, dynamic> data) {
    return Unit.fromJson(data);
  }
}
