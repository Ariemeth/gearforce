import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'roster_name_event.dart';
part 'roster_name_state.dart';

class RosterNameBloc extends Bloc<RosterNameEvent, RosterNameState> {
  RosterNameBloc() : super(RosterNameInitial('')) {
    on<RosterNameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
