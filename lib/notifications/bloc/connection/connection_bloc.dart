import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionsState> {
  ConnectionBloc({
    @required ParentTeacherConnectionRequestDto connectionRequest,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(connectionRequest != null),
        assert(authenticationRepository != null),
        _connectionRequest = connectionRequest,
        _authenticationRepository = authenticationRepository,
        super(ConnectionLoadInProgress());

  final ParentTeacherConnectionRequestDto _connectionRequest;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ConnectionsState> mapEventToState(
    ConnectionEvent event,
  ) async* {
    if (event is ConnectionLoaded) {
      yield _mapConnectionLoadedToState();
    } else if (event is ConnectionApproved) {
      yield* _mapConnectionApprovedToState();
    } else if (event is ConnectionRejected) {
      yield* _mapConnectionRejectedToState();
    }
  }

  ConnectionsState _mapConnectionLoadedToState() {
    return ConnectionLoadSuccess(
      performedAction: PerformedAction.none,
      connectionRequest: _connectionRequest,
    );
  }

  Stream<ConnectionsState> _mapConnectionApprovedToState() async* {
    yield ConnectionLoadInProgress();

    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var teacherApi = TeacherApi();
      await teacherApi.updateConnectionStatus(
          _connectionRequest.id, authKey, userId, 1);
      yield ConnectionLoadSuccess(
        performedAction: PerformedAction.approved,
        connectionRequest: _connectionRequest,
      );
    } catch (e) {
      yield ConnectionLoadFailure(e.toString());
    }
  }

  Stream<ConnectionsState> _mapConnectionRejectedToState() async* {
    yield ConnectionLoadInProgress();

    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var teacherApi = TeacherApi();
      await teacherApi.updateConnectionStatus(
          _connectionRequest.id, authKey, userId, 0);
      yield ConnectionLoadSuccess(
        performedAction: PerformedAction.rejected,
        connectionRequest: _connectionRequest,
      );
    } catch (e) {
      yield ConnectionLoadFailure(e.toString());
    }
  }
}
