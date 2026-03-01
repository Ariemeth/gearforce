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

class DuplicateSquad extends SquadEvent {
  final Squad squad;
  final String name;

  DuplicateSquad({required this.squad, required this.name});
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

class DuplicateModel extends SquadEvent {
  final Squad squad;
  final Model model;

  DuplicateModel({required this.squad, required this.model});
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

class UpdateModelUpgradeEnabled extends SquadEvent {
  final Squad squad;
  final Model model;
  final ModelUpgrade upgrade;
  final bool enabled;

  UpdateModelUpgradeEnabled({
    required this.squad,
    required this.model,
    required this.upgrade,
    required this.enabled,
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

class ReorderModel extends SquadEvent {
  final Squad squad;
  final int oldIndex;
  final int newIndex;

  ReorderModel({
    required this.squad,
    required this.oldIndex,
    required this.newIndex,
  });
}

class ReorderSquad extends SquadEvent {
  final int oldIndex;
  final int newIndex;

  ReorderSquad({required this.oldIndex, required this.newIndex});
}
