import 'package:gearforce/versions/v4/domain/entities/faction/faction.dart';
import 'package:gearforce/versions/v4/domain/entities/unit/unit.dart';

abstract class UnitRepository {
  Future<List<Unit>> getUnitsByFaction(Faction faction);
  Future<Unit?> getUnitById(String unitId);
}
