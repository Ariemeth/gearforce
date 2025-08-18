import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/blackTalons/units.dart';
import 'package:gearforce/src/predefined/units/north/north_units.dart';
import 'package:gearforce/src/predefined/units/south/south_units.dart';

class UnitFactory {
  static List<Unit> getUnitsForFaction(Faction faction) {
    switch (faction) {
      case Faction.blackTalons:
        return getBlackTalonUnits();
      case Faction.caprice:
        return [];
      case Faction.cef:
        return [];
      case Faction.eden:
        return [];
      case Faction.north:
        return getNorthUnits();
      case Faction.nuCoal:
        return [];
      case Faction.peaceRiver:
        return [];
      case Faction.south:
        return getSouthUnits();
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
