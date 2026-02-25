import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/squad_state.dart';

Squad _createSquad({
  int id = 1,
  String name = 'Test Squad',
  Role primaryRole = Role.gp,
}) {
  return Squad(
    id: id,
    name: name,
    primaryRole: primaryRole,
    models: const [],
    upgrades: const [],
  );
}

void main() {
  group('SquadState', () {
    group('initial state', () {
      test('empty squads list', () {
        const state = SquadState(squads: []);
        expect(state.squads, isEmpty);
        expect(state.selectedSquad, isNull);
        expect(state.hasSquads, isFalse);
        expect(state.squadCount, 0);
      });

      test('with squads', () {
        final squad = _createSquad();
        final state = SquadState(squads: [squad]);
        expect(state.hasSquads, isTrue);
        expect(state.squadCount, 1);
      });
    });

    group('copyWith', () {
      test('returns new instance with updated squads', () {
        const state = SquadState(squads: []);
        final squad = _createSquad();
        final updated = state.copyWith(squads: [squad]);
        expect(updated.squads.length, 1);
        expect(state.squads, isEmpty, reason: 'Original should be unchanged');
      });

      test('preserves selectedSquad when not provided', () {
        final squad = _createSquad();
        final state = SquadState(squads: [squad], selectedSquad: squad);
        final updated = state.copyWith(squads: [squad]);
        expect(updated.selectedSquad, squad);
      });

      test('updates selectedSquad when provided', () {
        final squad1 = _createSquad(id: 1, name: 'A');
        final squad2 = _createSquad(id: 2, name: 'B');
        final state = SquadState(
          squads: [squad1, squad2],
          selectedSquad: squad1,
        );
        final updated = state.copyWith(selectedSquad: squad2);
        expect(updated.selectedSquad, squad2);
      });

      test('clears selectedSquad when clearSelectedSquad is true', () {
        final squad = _createSquad();
        final state = SquadState(squads: [squad], selectedSquad: squad);
        final updated = state.copyWith(clearSelectedSquad: true);
        expect(updated.selectedSquad, isNull);
      });
    });

    group('addSquad', () {
      test('appends squad to list', () {
        const state = SquadState(squads: []);
        final squad = _createSquad();
        final updated = state.addSquad(squad);
        expect(updated.squads.length, 1);
        expect(updated.squads.first, squad);
      });

      test('preserves existing squads', () {
        final existing = _createSquad(id: 1, name: 'Existing');
        final state = SquadState(squads: [existing]);
        final newSquad = _createSquad(id: 2, name: 'New');
        final updated = state.addSquad(newSquad);
        expect(updated.squads.length, 2);
        expect(updated.squads[0], existing);
        expect(updated.squads[1], newSquad);
      });
    });

    group('removeSquad', () {
      test('removes the matching squad', () {
        final squad1 = _createSquad(id: 1, name: 'A');
        final squad2 = _createSquad(id: 2, name: 'B');
        final state = SquadState(squads: [squad1, squad2]);
        final updated = state.removeSquad(squad1);
        expect(updated.squads.length, 1);
        expect(updated.squads.first.id, 2);
      });

      test('returns same squads when removing non-existent squad', () {
        final squad1 = _createSquad(id: 1, name: 'A');
        final nonExistent = _createSquad(id: 99, name: 'Ghost');
        final state = SquadState(squads: [squad1]);
        final updated = state.removeSquad(nonExistent);
        expect(updated.squads.length, 1);
      });

      test('returns empty list when removing last squad', () {
        final squad = _createSquad();
        final state = SquadState(squads: [squad]);
        final updated = state.removeSquad(squad);
        expect(updated.squads, isEmpty);
        expect(updated.hasSquads, isFalse);
      });
    });

    group('updateSquad', () {
      test('replaces squad with matching ID', () {
        final squad = _createSquad(id: 1, name: 'Original');
        final state = SquadState(squads: [squad]);
        final renamed = squad.copyWith(name: 'Renamed');
        final updated = state.updateSquad(renamed);
        expect(updated.squads.first.name, 'Renamed');
        expect(updated.squads.first.id, 1);
      });

      test('preserves other squads', () {
        final squad1 = _createSquad(id: 1, name: 'Keep');
        final squad2 = _createSquad(id: 2, name: 'Change');
        final state = SquadState(squads: [squad1, squad2]);
        final changed = squad2.copyWith(name: 'Changed');
        final updated = state.updateSquad(changed);
        expect(updated.squads[0].name, 'Keep');
        expect(updated.squads[1].name, 'Changed');
      });

      test('no-op when ID not found', () {
        final squad = _createSquad(id: 1, name: 'A');
        final state = SquadState(squads: [squad]);
        final unknown = _createSquad(id: 99, name: 'Unknown');
        final updated = state.updateSquad(unknown);
        expect(updated.squads.length, 1);
        expect(updated.squads.first.name, 'A');
      });
    });
  });
}
