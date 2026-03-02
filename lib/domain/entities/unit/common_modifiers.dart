import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart' show Squad;
import 'package:gearforce/features/roster/bloc/roster_bloc.dart'
    show RosterState;

// Shared Typedefs
typedef RequirementCheck = bool Function(RosterState);
typedef SquadRequirementCheck = bool Function(RosterState, Squad);
typedef ModelRequirementCheck = bool Function(RosterState, Squad, Model);
typedef NameGenerator = String Function();

// Default implementations
class CommonModifiers {
  static bool defaultRequirementCheck(RosterState roster) => true;
  static bool defaultSquadRequirementCheck(RosterState roster, Squad squad) =>
      true;
  static bool defaultModelRequirementCheck(
    RosterState roster,
    Squad squad,
    Model model,
  ) => true;
}
