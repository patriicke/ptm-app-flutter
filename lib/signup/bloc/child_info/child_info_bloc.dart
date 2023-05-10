import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/models/child_info.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'child_info_event.dart';
part 'child_info_state.dart';

class ChildInfoBloc extends Bloc<ChildInfoEvent, ChildInfoState> {
  ChildInfoBloc({
    @required UserRepository userRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(userRepository != null),
        assert(authenticationRepository != null),
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(ChildInfoLoadInProgress());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ChildInfoState> mapEventToState(
    ChildInfoEvent event,
  ) async* {
    if (event is ChildNameUpdated) {
      yield _mapChildNameUpdatedToState(event, state);
    } else if (event is ChildGradeUpdated) {
      yield _mapChildGradeUpdatedToState(event, state);
    } else if (event is ChildInfoSubmitted) {
      yield* _mapChildInfoSubmittedToState(event, state);
    } else if (event is ChildAdded) {
      yield _mapChildAddedToState(event, state);
    } else if (event is ChildInfoLoaded) {
      yield* _mapChildInfoLoadedToState();
    }
  }

  Stream<ChildInfoState> _mapChildInfoLoadedToState() async* {
    yield ChildInfoLoadInProgress();
    try {
      var defaultApi = TypesApi();
      var response = await defaultApi.gradePhpGet();

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling TypesApi->gradePhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TypesApi->gradePhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }

      yield ChildInfoLoadSuccess(grades: response.data);
    } catch (e) {
      yield ChildInfoLoadFailure(e.toString());
    }
  }

  ChildInfoState _mapChildNameUpdatedToState(
    ChildNameUpdated event,
    ChildInfoState state,
  ) {
    if (state is ChildInfoLoadSuccess) {
      final childName = ChildName.dirty(event.childName);
      return state.copyWith(
        childName: childName,
        status: Formz.validate([
          childName,
          state.childGrade,
        ]),
      );
    } else
      return state;
  }

  ChildInfoState _mapChildGradeUpdatedToState(
    ChildGradeUpdated event,
    ChildInfoState state,
  ) {
    if (state is ChildInfoLoadSuccess) {
      final childGrade = ChildGrade.dirty(event.childGrade);
      return state.copyWith(
        childGrade: childGrade,
        status: Formz.validate([
          state.childName,
          childGrade,
        ]),
      );
    } else
      return state;
  }

  ChildInfoState _mapChildAddedToState(
    ChildAdded event,
    ChildInfoState state,
  ) {
    if (state is ChildInfoLoadSuccess) {
      if (state.status.isValidated) {
        var newChild = ParentChild();
        newChild.name = state.childName.value;
        newChild.grade = state.childGrade.value;

        var updatedChildren = List<ParentChild>();
        state.children.forEach((child) => updatedChildren.add(child));
        updatedChildren.add(newChild);

        return state.copyWith(
          children: updatedChildren,
        );
      } else
        return state;
    } else
      return state;
  }

  Stream<ChildInfoState> _mapChildInfoSubmittedToState(
    ChildInfoSubmitted event,
    ChildInfoState state,
  ) async* {
    if (state is ChildInfoLoadSuccess) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _userRepository.registerParentChildren(
          _authenticationRepository.currentUser.id,
          _authenticationRepository.authKey,
          state.children,
        );
        await _authenticationRepository
            .updateUserStatus(UserStatus.parentChildrenSubmitted);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else
      yield state;
  }
}
