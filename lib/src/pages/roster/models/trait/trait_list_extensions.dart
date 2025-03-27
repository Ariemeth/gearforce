import 'package:gearforce/src/pages/roster/models/trait/trait.dart';

extension TraitListExtension on List<Trait> {
  /// Returns a deep copy of the list of traits.
  List<Trait> copyWith() {
    return map((trait) => trait.copyWith()).toList();
  }
}
