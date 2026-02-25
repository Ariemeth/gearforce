import 'package:gearforce/domain/entities/unit/squad.dart' show Squad;
import 'package:gearforce/features/roster/bloc/roster_bloc.dart'
    show RosterState;

// Shared Typedefs
typedef RequirementCheck = bool Function(RosterState, Squad);
typedef NameGenerator = String Function();

// Default implementations
class CommonModifiers {
  static bool defaultRequirementCheck(RosterState roster, Squad squad) => true;
}
