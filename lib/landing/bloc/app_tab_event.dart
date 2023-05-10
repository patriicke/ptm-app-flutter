part of 'app_tab_bloc.dart';

abstract class AppTabEvent extends Equatable {
  const AppTabEvent();

  @override
  List<Object> get props => [];
}

class TabUpdated extends AppTabEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
