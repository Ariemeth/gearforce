import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';

class JsonWeaponRepository implements WeaponRepository {
  final Map<String, Map<String, dynamic>> _weaponsByCode = {};
  bool _isLoaded = false;

  @override
  Future<List<Weapon>> getWeapons({WeaponSize size = WeaponSize.light}) async {
    await _ensureLoaded();
    return _weaponsByCode.values
        .map((json) => Weapon.fromJson(json, size))
        .toList();
  }

  @override
  Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    if (!_isLoaded) {
      throw StateError('JsonWeaponRepository not loaded. Call load() first.');
    }
    final size = WeaponSize.fromCode(code);
    final baseCode = code.substring(1);

    final weaponJson = _weaponsByCode[baseCode];

    if (weaponJson == null) return null;

    return Weapon.fromJson(weaponJson, size, isReact: hasReact);
  }

  Future<void> load() async {
    await _ensureLoaded();
  }

  Future<void> _ensureLoaded() async {
    if (_isLoaded) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/weapons/weapons.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      for (final item in jsonData) {
        final weaponMap = item as Map<String, dynamic>;
        _weaponsByCode[weaponMap['code'] as String] = weaponMap;
      }
      _isLoaded = true;
    } catch (e) {
      throw StateError('Failed to load weapon data: $e');
    }
  }
}
