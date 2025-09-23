part of 'roster_bloc.dart';

sealed class SquadEvent extends RosterEvent {}

class AddNewSquad extends SquadEvent {
  final String name;
  final Role primaryRole;
  final Role? secondaryRole;
  final Level level;

  AddNewSquad({
    required this.name,
    this.primaryRole = Role.gp,
    this.secondaryRole,
    this.level = Level.regular,
  });
}

class RemoveSquad extends SquadEvent {
  final Squad squad;
  RemoveSquad({required this.squad});
}

class UpdateSquadRoles extends SquadEvent {
  final Squad squad;
  final Role primaryRole;
  final Role? secondaryRole;

  UpdateSquadRoles({
    required this.squad,
    required this.primaryRole,
    this.secondaryRole,
  });
}

class AddModel extends SquadEvent {
  final Squad squad;
  final Model model;

  AddModel({required this.squad, required this.model});
}

class UpdateSquad extends SquadEvent {
  final Squad updatedSquad;
  UpdateSquad({required this.updatedSquad});
}

class UpdateSquads extends SquadEvent {
  final List<Squad> squads;
  UpdateSquads({required this.squads});
}
