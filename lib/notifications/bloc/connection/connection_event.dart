part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

class ConnectionLoaded extends ConnectionEvent {
  const ConnectionLoaded();
}

class ConnectionApproved extends ConnectionEvent {
  const ConnectionApproved();
}

class ConnectionRejected extends ConnectionEvent {
  const ConnectionRejected();
}
