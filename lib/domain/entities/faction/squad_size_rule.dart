import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:meta/meta.dart';

@immutable
class SquadSizeRule extends Rule {
  final int minimumEffectiveUnits;
  final int maximumUnits;
  final int Function(Model model)? unitWeightResolver;

  static const SquadSizeRule standard = SquadSizeRule(
    minimumEffectiveUnits: 4,
    maximumUnits: 9,
  );

  const SquadSizeRule({
    super.name = 'Squad Size Rule',
    super.id = 'squad-size-rule',
    super.description =
        'A squad may include between 4 and 9 units by standard composition rules.',
    super.isEnabled = true,
    super.canBeToggled = false,
    super.requirementCheck,
    required this.minimumEffectiveUnits,
    required this.maximumUnits,
    this.unitWeightResolver,
  }) : assert(
         minimumEffectiveUnits > 0,
         'minimumEffectiveUnits must be greater than 0',
       ),
       assert(maximumUnits > 0, 'maximumUnits must be greater than 0');

  int getUnitWeight(Model model) {
    final customWeight = unitWeightResolver?.call(model);
    if (customWeight != null) {
      return customWeight;
    }

    final hasMultipleActions = model.actions.value > 1;
    final hasRepairOrMedic = model.traits.any(
      (trait) =>
          trait.name == Trait.repair().name || trait.name == Trait.medic().name,
    );

    return (hasMultipleActions || hasRepairOrMedic) ? 2 : 1;
  }

  int getEffectiveUnitCount(Iterable<Model> models) {
    return models.fold(0, (total, model) => total + getUnitWeight(model));
  }

  bool isComplete(Iterable<Model> models) {
    return getEffectiveUnitCount(models) >= minimumEffectiveUnits;
  }

  bool canAddAnyModel(Iterable<Model> models) {
    return models.length < maximumUnits;
  }

  bool canAddModel(Iterable<Model> models, Model model) {
    return canAddAnyModel(models);
  }
}
