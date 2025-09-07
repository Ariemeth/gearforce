import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/models/roster/faction.dart';

void main() {
  group('Faction enum', () {
    test('All factions should have at least one subfaction', () {
      for (final faction in Faction.values) {
        expect(
          faction.subfactions.isNotEmpty,
          true,
          reason: '${faction.displayName} does not have any subfactions.',
        );
      }
    });
  });
}
