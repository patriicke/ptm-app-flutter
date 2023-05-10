import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_tab_event.dart';

enum AppTab { meeetings, comms, notifications, reports, profile }

class AppTabBloc extends Bloc<AppTabEvent, AppTab> {
  AppTabBloc() : super(AppTab.meeetings);

  @override
  Stream<AppTab> mapEventToState(
    AppTabEvent event,
  ) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
