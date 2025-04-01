import 'package:gearforce/src/models/roster/trait/trait.dart';

extension TraitListExtension on List<Trait> {
  /// Returns a deep copy of the list of traits.
  List<Trait> copyWith() {
    return map((trait) => trait.copyWith()).toList();
  }
}
