import 'package:gearforce/versions/v4/domain/entities/equipment/trait.dart';

extension TraitListExtension on List<Trait> {
  /// Returns a deep copy of the list of traits.
  List<Trait> copyWith() {
    return map((trait) => trait.copyWith()).toList();
  }
}
