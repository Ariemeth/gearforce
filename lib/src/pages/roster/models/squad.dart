import 'package:meta/meta.dart';
import 'package:gearforce/src/pages/roster/models/unit.dart';

@immutable
class Squad {
  final String id;
  final String primaryRole;
  final String? secondaryRole;
  final List<Unit> units;

  const Squad({
    required this.id,
    required this.primaryRole,
    this.secondaryRole,
    required this.units,
  });

  Squad copyWith({List<Unit>? units}) {
    return Squad(
      id: id,
      primaryRole: primaryRole,
      secondaryRole: secondaryRole,
      units: units ?? this.units,
    );
  }
}
