import 'package:gearforce/src/models/roster/squad.dart' show Squad;
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart'
    show RosterState;

// Shared Typedefs
typedef RequirementCheck = bool Function(RosterState, Squad);
typedef NameGenerator = String Function();

// Default implementations
class CommonModifiers {
  static bool defaultRequirementCheck(RosterState roster, Squad squad) => true;
}
