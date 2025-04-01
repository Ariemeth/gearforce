import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/north_models.dart';
import 'package:gearforce/src/predefined/units/south_models.dart';

class UnitFactory {
  static List<Unit> getUnitsForFaction(Faction faction) {
    switch (faction) {
      case Faction.blackTalons:
        return [];
      case Faction.caprice:
        return [];
      case Faction.cef:
        return [];
      case Faction.eden:
        return [];
      case Faction.north:
        return NorthUnits.getUnits();
      case Faction.nuCoal:
        return [];
      case Faction.peaceRiver:
        return [];
      case Faction.south:
        return SouthUnits.getUnits();
      case Faction.utopia:
        return [];
    }
  }

  static Unit? getUnitByName(Faction faction, String unitName) {
    final unitList = getUnitsForFaction(faction);
    if (unitList
        .any((unit) => unit.name.toLowerCase() == unitName.toLowerCase())) {
      return null;
    }
    return unitList.firstWhere(
      (unit) => unit.name.toLowerCase() == unitName.toLowerCase(),
    );
  }
}
