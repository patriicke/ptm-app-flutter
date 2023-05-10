import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/login/models/email.dart';
import 'package:meetings/login/models/password.dart';
import 'package:meetings/signup/models/mobile_no.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'edit_details_event.dart';
part 'edit_details_state.dart';

class EditDetailsBloc extends Bloc<EditDetailsEvent, EditDetailsState> {
  EditDetailsBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(EditDetailsState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<EditDetailsState> mapEventToState(
    EditDetailsEvent event,
  ) async* {
    if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is PasswordUpdated) {
      yield _mapPasswordUpdatedToState(event, state);
    } else if (event is PhoneNoUpdated) {
      yield _mapPhoneNoUpdatedToState(event, state);
    } else if (event is EditDetailsSubmitted) {
      yield* _mapEditDetailsSubmittedToState(event, state);
    }
  }

  EditDetailsState _mapEmailUpdatedToState(
      EmailUpdated event, EditDetailsState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.phoneNo,
        state.password,
      ]),
    );
  }

  EditDetailsState _mapPasswordUpdatedToState(
      PasswordUpdated event, EditDetailsState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([
        // state.email,
        state.phoneNo,
        password,
      ]),
    );
  }

  EditDetailsState _mapPhoneNoUpdatedToState(
      PhoneNoUpdated event, EditDetailsState state) {
    final phoneNo = MobileNo.dirty(event.phoneNo);
    return state.copyWith(
      phoneNo: phoneNo,
      status: Formz.validate([
        // state.email,
        phoneNo,
        state.password,
      ]),
    );
  }

  Stream<EditDetailsState> _mapEditDetailsSubmittedToState(
      EditDetailsSubmitted event, EditDetailsState state) async* {
    yield state.copyWith(
      status: FormzStatus.submissionInProgress,
    );
    try {
      var userApi = UserApi();
      var vm = UserEditVm()
        ..email = null
        ..password = state.password.value
        ..phone = state.phoneNo.value;
      var userId = _authenticationRepository.currentUser.id;
      var authKey = _authenticationRepository.authKey;
      var response = await userApi.updateUser(userId, authKey, vm);

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling UserApi->updateUser. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling UserApi->updateUser. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }
      await _authenticationRepository.logOut();
      yield state.copyWith(
        status: FormzStatus.submissionSuccess,
        email: const Email.pure(),
        password: const Password.pure(),
        phoneNo: const MobileNo.pure(),
      );
    } catch (e) {
      yield state.copyWith(
          status: FormzStatus.submissionFailure, error: e.toString());
    }
  }
}
