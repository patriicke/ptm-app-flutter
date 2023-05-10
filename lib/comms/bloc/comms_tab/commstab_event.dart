part of 'commstab_bloc.dart';

abstract class CommstabEvent extends Equatable {
  const CommstabEvent();

  @override
  List<Object> get props => [];
}

class CommstabLoaded extends CommstabEvent {
  const CommstabLoaded();
}
