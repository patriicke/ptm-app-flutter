import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/models/verification_code.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc({
    @required UserRepository userRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(userRepository != null),
        assert(authenticationRepository != null),
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const VerificationState());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<VerificationState> mapEventToState(
      VerificationEvent event,
      ) async* {
    if (event is VerificationStarted) {
      yield _mapVerificationStartedToState();
    } else if (event is VerificationCodeUpdated) {
      yield _mapVerificationCodeUpdatedToState(event, state);
    } else if (event is VerificationSubmitted) {
      yield* _mapVerificationSubmittedToState(event, state);
    }
  }

  VerificationState _mapVerificationStartedToState() {
    return VerificationState(
        emailAddress: _authenticationRepository.currentUser.email,
        phoneNumber:_authenticationRepository.currentUser.phone);
  }

  VerificationState _mapVerificationCodeUpdatedToState(
      VerificationCodeUpdated event,
      VerificationState state,
      ) {
    log(event.verificationCode);
    final verificationCode = VerificationCode.dirty(event.verificationCode);
    return state.copyWith(
      verificationCode: verificationCode,
      status: Formz.validate([
        verificationCode,
      ]),
    );
  }

  Stream<VerificationState> _mapVerificationSubmittedToState(
      VerificationSubmitted event,
      VerificationState state,
      ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.verifyAccount(
          oneTimePasscode: state.verificationCode.value,
        );
        yield state.copyWith(
          verificationCode: VerificationCode.pure(),
          status: FormzStatus.submissionSuccess,
        );
      } on Exception catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    }
  }
}
