import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/login/models/email.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'email_invite_form_event.dart';
part 'email_invite_form_state.dart';

class EmailInviteFormBloc
    extends Bloc<EmailInviteFormEvent, EmailInviteFormState> {
  EmailInviteFormBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(EmailInviteFormState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<EmailInviteFormState> mapEventToState(
    EmailInviteFormEvent event,
  ) async* {
    if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is EmailInviteFormSubmitted) {
      yield* _mapEmailInviteFormSubmittedToState(event, state);
    }
  }

  EmailInviteFormState _mapEmailUpdatedToState(
      EmailUpdated event, EmailInviteFormState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<EmailInviteFormState> _mapEmailInviteFormSubmittedToState(
      EmailInviteFormSubmitted event, EmailInviteFormState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        var userId = _authenticationRepository.currentUser.id;
        var authKey = _authenticationRepository.authKey;
        var userApi = UserApi();
        var response =
            await userApi.sendEmailInvite(userId, authKey, state.email.value);

        if (response.code != 200) {
          log('Exception when calling UserApi->sendEmailInvite. code: ${response.code}, message: ${response.message}\n');
          throw Exception(
              'Exception when calling UserApi->sendEmailInvite. code: ${response.code}, message: ${response.message}\n');
        }
        yield state.copyWith(
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
