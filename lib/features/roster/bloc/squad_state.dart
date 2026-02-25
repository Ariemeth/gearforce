import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:meta/meta.dart';

@immutable
class SquadState {
  final List<Squad> squads;
  final Squad? selectedSquad;

  const SquadState({required this.squads, this.selectedSquad});

  bool get hasSquads => squads.isNotEmpty;
  int get squadCount => squads.length;

  SquadState copyWith({
    List<Squad>? squads,
    Squad? selectedSquad,
    bool clearSelectedSquad = false,
  }) {
    return SquadState(
      squads: squads ?? this.squads,
      selectedSquad: clearSelectedSquad
          ? null
          : (selectedSquad ?? this.selectedSquad),
    );
  }

  // Convenience methods
  SquadState addSquad(Squad squad) {
    return copyWith(squads: [...squads, squad]);
  }

  SquadState removeSquad(Squad squad) {
    return copyWith(squads: squads.where((s) => s != squad).toList());
  }

  SquadState updateSquad(Squad updatedSquad) {
    final updatedSquads = squads.map((squad) {
      return squad.id == updatedSquad.id ? updatedSquad : squad;
    }).toList();
    return copyWith(squads: updatedSquads);
  }
}
