import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

abstract class UnitRepository {
  Future<List<Unit>> getUnitsByFaction(Faction faction);
  Future<Unit?> getUnitById(String unitId);
}
