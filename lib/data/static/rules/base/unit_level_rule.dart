import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:meta/meta.dart';

@immutable
class UnitLevelRule extends Rule {
  static const UnitLevelRule standard = UnitLevelRule();

  const UnitLevelRule({
    super.name = 'Unit Level Rule',
    super.id = 'unit-level-rule',
    super.description =
        'Limits the number of squads that may include green, veteran, or elite units.',
    super.isEnabled = true,
    super.canBeToggled = false,
    super.requirementCheck,
  });

  bool canAssignUnitLevel({
    required Model model,
    required UnitLevel newLevel,
    required Squad squad,
    required List<Squad> allSquads,
    required AssetTable assetTable,
  }) {
    if (newLevel == model.level) {
      return true;
    }

    final limit = _getLimitForLevel(assetTable, newLevel);
    if (limit == null) {
      return true;
    }

    final squadsWithLevel = _countSquadsWithLevelAfterUpdate(
      model: model,
      newLevel: newLevel,
      squad: squad,
      allSquads: allSquads,
    );

    return squadsWithLevel <= limit;
  }

  int? _getLimitForLevel(AssetTable assetTable, UnitLevel level) {
    switch (level) {
      case UnitLevel.green:
        return assetTable.greenSquads;
      case UnitLevel.regular:
        return assetTable.regularSquads;
      case UnitLevel.veteran:
        return assetTable.veteranSquads;
      case UnitLevel.elite:
        return assetTable.eliteSquads;
    }
  }

  int _countSquadsWithLevelAfterUpdate({
    required Model model,
    required UnitLevel newLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    int count = 0;
    for (final currentSquad in allSquads) {
      final hasLevel = currentSquad.id == squad.id
          ? true
          : currentSquad.models.any((m) => m.level == newLevel);
      if (hasLevel) {
        count++;
      }
    }

    return count;
  }
}
