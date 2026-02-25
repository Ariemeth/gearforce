import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';

class UnitFactory {
  static Future<List<Unit>> getUnitsForFaction(
    UnitRepository unitRepository,
    Faction faction,
  ) async {
    final factionId = faction.name.toLowerCase();
    return await unitRepository.getUnitsByFaction(factionId);
  }

  static Future<Unit?> getUnitByName(
    UnitRepository unitRepository,
    Faction faction,
    String unitName,
  ) async {
    final unitList = await getUnitsForFaction(unitRepository, faction);
    try {
      return unitList.firstWhere(
        (unit) => unit.name.toLowerCase() == unitName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
