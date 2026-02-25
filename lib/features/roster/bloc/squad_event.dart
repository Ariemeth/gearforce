part of 'roster_bloc.dart';

sealed class SquadEvent extends RosterEvent {}

class AddNewSquad extends SquadEvent {
  final String name;
  final Role primaryRole;
  final Role? secondaryRole;

  AddNewSquad({
    required this.name,
    this.primaryRole = Role.gp,
    this.secondaryRole,
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
  final ModelBase base;
  final Variant variant;

  AddModel({required this.squad, required this.base, required this.variant});
}

class RemoveModel extends SquadEvent {
  final Squad squad;
  final Model model;

  RemoveModel({required this.squad, required this.model});
}

class UpdateModelLevel extends SquadEvent {
  final Squad squad;
  final Model model;
  final UnitLevel level;

  UpdateModelLevel({
    required this.squad,
    required this.model,
    required this.level,
  });
}

class UpdateModelIsDuelist extends SquadEvent {
  final Squad squad;
  final Model model;
  final bool isDuelist;

  UpdateModelIsDuelist({
    required this.squad,
    required this.model,
    required this.isDuelist,
  });
}

class UpdateModelCommandLevel extends SquadEvent {
  final Squad squad;
  final Model model;
  final Command commandLevel;

  UpdateModelCommandLevel({
    required this.squad,
    required this.model,
    required this.commandLevel,
  });
}

class UpdateSquad extends SquadEvent {
  final Squad updatedSquad;
  UpdateSquad({required this.updatedSquad});
}

class RenameSquad extends SquadEvent {
  final Squad squad;
  final String newName;
  RenameSquad({required this.squad, required this.newName});
}

class UpdateSquads extends SquadEvent {
  final List<Squad> squads;
  UpdateSquads({required this.squads});
}
