import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:formz/formz.dart';
import 'package:meetings/login/models/password.dart';
import 'package:meetings/signup/models/verification_code.dart';
import 'package:meta/meta.dart';
import 'package:swagger_api/swagger_api.dart';

part 'forgot_password_verification_event.dart';
part 'forgot_password_verification_state.dart';

class ForgotPasswordVerificationBloc extends Bloc<
    ForgotPasswordVerificationEvent, ForgotPasswordVerificationState> {
  ForgotPasswordVerificationBloc({
    @required int verificationEventId,
  })  : assert(verificationEventId != null),
        _verificationEventId = verificationEventId,
        super(ForgotPasswordVerificationState());

  final int _verificationEventId;

  @override
  Stream<ForgotPasswordVerificationState> mapEventToState(
    ForgotPasswordVerificationEvent event,
  ) async* {
    if (event is VerificationCodeUpdated) {
      yield _mapVerificationCodeUpdatedToState(event, state);
    } else if (event is PasswordUpdated) {
      yield _mapPasswordUpdatedToState(event, state);
    } else if (event is VerificationCodeSubmitted) {
      yield* _mapVerificationCodeSubmittedToState(event, state);
    }
  }

  ForgotPasswordVerificationState _mapVerificationCodeUpdatedToState(
      VerificationCodeUpdated event, ForgotPasswordVerificationState state) {
    final verificationCode = VerificationCode.dirty(event.verificationCode);
    return state.copyWith(
      verificationCode: verificationCode,
      status: Formz.validate([
        verificationCode,
        state.password,
      ]),
    );
  }

  ForgotPasswordVerificationState _mapPasswordUpdatedToState(
      PasswordUpdated event, ForgotPasswordVerificationState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([
        state.verificationCode,
        password,
      ]),
    );
  }

  Stream<ForgotPasswordVerificationState> _mapVerificationCodeSubmittedToState(
      VerificationCodeSubmitted event,
      ForgotPasswordVerificationState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        var userApi = UserApi();
        var response = await userApi.changePasswordPhpGet(
          state.verificationCode.value,
          _verificationEventId.toString(),
          state.password.value,
        );

        if (response.apiResponseMessage.code != 200) {
          log('Exception when calling UserApi->changePasswordPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          throw Exception(
              'Exception when calling UserApi->changePasswordPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        }

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    }
  }
}
