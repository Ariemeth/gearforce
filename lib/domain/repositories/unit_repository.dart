import 'package:gearforce/domain/entities/unit/unit.dart';

abstract class UnitRepository {
  Future<List<Unit>> getUnitsByFaction(String factionId);
}
