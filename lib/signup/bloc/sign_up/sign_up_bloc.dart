import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/login/models/password.dart';
import 'package:meetings/signup/models/about.dart';
import 'package:meetings/login/models/email.dart';
import 'package:meetings/signup/models/full_name.dart';
import 'package:meetings/signup/models/mobile_no.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    @required UserRepository userRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(userRepository != null),
        assert(authenticationRepository != null),
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignUpState> mapEventToState(
      SignUpEvent event,
      ) async* {
    if (event is SignUpStarted) {
      yield _mapSignUpStartedToState(event, state);
    } else if (event is FullNameUpdated) {
      yield _mapFullNameUpdatedToState(event, state);
    } else if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is PasswordUpdated) {
      yield _mapPasswordUpdatedToState(event, state);
    } else if (event is MobileNoUpdated) {
      yield _mapMobileNoUpdatedToState(event, state);
    } else if (event is AboutUpdated) {
      yield _mapAboutUpdatedToState(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmittedToState(event, state);
    }
  }

  SignUpState _mapSignUpStartedToState(
      SignUpStarted event,
      SignUpState state,
      ) {
    return SignUpState(signupType: event.signupType);
  }

  SignUpState _mapFullNameUpdatedToState(
      FullNameUpdated event,
      SignUpState state,
      ) {
    final fullName = FullName.dirty(event.fullName);
    return state.copyWith(
      fullName: fullName,
      status: Formz.validate([
        fullName,
        state.email,
        state.password,
        state.mobileNo,
        state.about,
      ]),
    );
  }

  SignUpState _mapEmailUpdatedToState(
      EmailUpdated event,
      SignUpState state,
      ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        state.fullName,
        email,
        state.password,
        state.mobileNo,
        state.about,
      ]),
    );
  }

  SignUpState _mapPasswordUpdatedToState(
      PasswordUpdated event,
      SignUpState state,
      ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([
        state.fullName,
        state.email,
        password,
        state.mobileNo,
        state.about,
      ]),
    );
  }

  SignUpState _mapMobileNoUpdatedToState(
      MobileNoUpdated event,
      SignUpState state,
      ) {
    final mobileNo = MobileNo.dirty(event.mobileNo);
    return state.copyWith(
      mobileNo: mobileNo,
      status: Formz.validate([
        state.fullName,
        state.email,
        state.password,
        mobileNo,
        state.about,
      ]),
    );
  }

  SignUpState _mapAboutUpdatedToState(
      AboutUpdated event,
      SignUpState state,
      ) {
    final about = About.dirty(event.about);
    return state.copyWith(
      about: about,
      status: Formz.validate([
        state.fullName,
        state.email,
        state.password,
        state.mobileNo,
        about,
      ]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(
      SignUpSubmitted event,
      SignUpState state,
      ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.signupUser(
          state.fullName.value,
          state.email.value,
          state.password.value,
          state.mobileNo.value,
          state.about.value,
          state.signupType,
        );
        yield state.copyWith(
          fullName: FullName.pure(),
          email: Email.pure(),
          password: Password.pure(),
          mobileNo: MobileNo.pure(),
          about: About.pure(),
          status: FormzStatus.submissionSuccess,
        );
      } catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          signupError: e.toString(),
        );
      }
    }
  }
}
