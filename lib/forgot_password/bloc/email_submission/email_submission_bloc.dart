import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/login/models/email.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../../signup/models/mobile_no.dart';

part 'email_submission_event.dart';
part 'email_submission_state.dart';

class EmailSubmissionBloc
    extends Bloc<EmailSubmissionEvent, EmailSubmissionState> {
  EmailSubmissionBloc() : super(EmailSubmissionState());

  @override
  Stream<EmailSubmissionState> mapEventToState(
      EmailSubmissionEvent event,
      ) async* {
    if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    }
    /*else if (event is PhoneNoUpdated) {
      yield _mapPhoneNoUpdatedToState(event, state);
    }*/
    else if (event is EmailSubmissionSubmitted) {
      yield* _mapEmailSubmissionSubmittedToState(event, state);
    }
  }

  EmailSubmissionState _mapEmailUpdatedToState(
      EmailUpdated event, EmailSubmissionState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      //status: Formz.validate([email,state.phoneNo,]),
      status: Formz.validate([email]),
    );
  }

  /*EmailSubmissionState _mapPhoneNoUpdatedToState(
      PhoneNoUpdated event, EmailSubmissionState state) {
    final phoneNo = MobileNo.dirty(event.phoneNo);
    return state.copyWith(
      phoneNo: phoneNo,
      status: Formz.validate([
        state.email,
        phoneNo,
      ]),
    );
  }*/

  Stream<EmailSubmissionState> _mapEmailSubmissionSubmittedToState(
      EmailSubmissionSubmitted event, EmailSubmissionState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        var userApi = UserApi();
        var response = await userApi.forgotPhpGet(state.email.value);

        if (response.apiResponseMessage.code != 200) {
          log('Exception when calling UserApi->sendEmailInvite. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          throw Exception(
              'Exception when calling UserApi->sendEmailInvite. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        }
        yield state.copyWith(
          signupEventId: response.data.signupEventId,
          status: FormzStatus.submissionSuccess,
        );
      } catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    }
  }
}
