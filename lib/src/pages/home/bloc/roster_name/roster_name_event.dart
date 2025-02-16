part of 'roster_name_bloc.dart';

@immutable
sealed class RosterNameEvent {}

class UpdateRosterName extends RosterNameEvent {
  final String name;

  UpdateRosterName(this.name);
}
