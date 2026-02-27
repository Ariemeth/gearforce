import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:meta/meta.dart';

@immutable
class DuelistRule extends Rule {
  static const DuelistRule standard = DuelistRule();

  const DuelistRule({
    super.name = 'Duelist Rule',
    super.id = 'duelist-rule',
    super.description =
        'Limits the number of duelists based on the asset table. '
        'A duelist cannot be green and a green unit cannot become a duelist. '
        'Making a unit a duelist costs 1 TV.',
    super.isEnabled = true,
    super.canBeToggled = false,
    super.requirementCheck,
  });

  bool canAssignDuelist({
    required Model model,
    required bool newDuelistStatus,
    required Squad squad,
    required List<Squad> allSquads,
    required AssetTable assetTable,
  }) {
    // If the status isn't changing, allow it
    if (newDuelistStatus == model.isDuelist) {
      return true;
    }

    // If turning off duelist status, always allow it
    if (!newDuelistStatus) {
      return true;
    }

    // Cannot make a green unit a duelist
    if (model.level == UnitLevel.green) {
      return false;
    }

    // Check if we're at the duelist limit
    final limit = assetTable.duelistOrAces;
    if (limit == null) {
      // Unlimited duelists
      return true;
    }

    // Count duelists after the update
    final duelistsAfterUpdate = _countDuelistsAfterUpdate(
      model: model,
      newDuelistStatus: newDuelistStatus,
      squad: squad,
      allSquads: allSquads,
    );

    return duelistsAfterUpdate <= limit;
  }

  int _countDuelistsAfterUpdate({
    required Model model,
    required bool newDuelistStatus,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    int count = 0;

    for (final s in allSquads) {
      for (final m in s.models) {
        if (m.id == model.id && s.id == squad.id) {
          // This is the model being updated
          if (newDuelistStatus) {
            count++;
          }
        } else if (m.isDuelist) {
          count++;
        }
      }
    }

    return count;
  }
}
