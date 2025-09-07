import 'package:meta/meta.dart';
import 'package:gearforce/src/models/roster/squad.dart';

@immutable
class CombatGroup {
  final String id;
  final List<Squad> squads;

  const CombatGroup({required this.id, required this.squads});

  CombatGroup copyWith({List<Squad>? squads}) {
    return CombatGroup(id: id, squads: squads ?? this.squads);
  }
}
