part of 'connection_bloc.dart';

abstract class ConnectionsState extends Equatable {
  const ConnectionsState();

  @override
  List<Object> get props => [];
}

class ConnectionLoadInProgress extends ConnectionsState {}

enum PerformedAction { none, approved, rejected }

class ConnectionLoadSuccess extends ConnectionsState {
  final PerformedAction performedAction;
  final ParentTeacherConnectionRequestDto connectionRequest;
  ConnectionLoadSuccess({
    this.performedAction,
    this.connectionRequest,
  });

  @override
  List<Object> get props => [performedAction, connectionRequest];
}

class ConnectionLoadFailure extends ConnectionsState {
  final String error;
  ConnectionLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
