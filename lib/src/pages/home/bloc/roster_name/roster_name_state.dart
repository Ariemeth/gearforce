part of 'roster_name_bloc.dart';

@immutable
sealed class RosterNameState {
  final String name;

  const RosterNameState(this.name);
}

final class RosterNameInitial extends RosterNameState {
  const RosterNameInitial(super.name);
}
