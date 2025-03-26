part of 'roster_bloc.dart';

@immutable
abstract class RosterState {
  final String playerName;
  final String rosterName;
  final List<Squad> squads;
  final Faction? selectedFaction;
  final Subfaction? selectedSubfaction;

  const RosterState(
    this.playerName,
    this.rosterName,
    this.squads, {
    this.selectedFaction,
    this.selectedSubfaction,
  });
}

class RosterInitial extends RosterState {
  RosterInitial() : super('', '', []);
}

class RosterUpdated extends RosterState {
  const RosterUpdated(
    super.playerName,
    super.rosterName,
    super.squads, {
    super.selectedFaction,
    super.selectedSubfaction,
  });
}
