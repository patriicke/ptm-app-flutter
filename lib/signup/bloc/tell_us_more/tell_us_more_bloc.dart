import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/models/tell_us_more.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'tell_us_more_event.dart';
part 'tell_us_more_state.dart';

class TellUsMoreBloc extends Bloc<TellUsMoreEvent, TellUsMoreState> {
  TellUsMoreBloc({
    @required UserRepository userRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(userRepository != null),
        assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(TellUsMoreLoadInProgress());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<TellUsMoreState> mapEventToState(
    TellUsMoreEvent event,
  ) async* {
    if (event is SchoolNameUpdated) {
      yield _mapSchoolNameUpdatedToState(event, state);
    } else if (event is SchoolStateUpdated) {
      yield _mapSchoolStateUpdatedToState(event, state);
    } else if (event is SchoolCityUpdated) {
      yield _mapSchoolCityUpdatedToState(event, state);
    } else if (event is SchoolZipCodeUpdated) {
      yield _mapSchoolZipCodeUpdatedToState(event, state);
    } else if (event is TellUsMoreSubmitted) {
      yield* _mapTellUsMoreSubmittedToState(event, state);
    } else if (event is TellUsMoreLoaded) {
      yield* _mapTellUsMoreLoadedToState();
    }
  }

  Stream<TellUsMoreState> _mapTellUsMoreLoadedToState() async* {
    yield TellUsMoreLoadInProgress();

    try {
      var typesApi = TypesApi();
      var response = await typesApi.cityPhpGet();

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling TypesApi->cityPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TypesApi->cityPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }

      yield TellUsMoreLoadSuccess(cities: response.data);
    } catch (e) {
      yield TellUsMoreLoadFailure(e.toString());
    }
  }

  TellUsMoreState _mapSchoolNameUpdatedToState(
    SchoolNameUpdated event,
    TellUsMoreState state,
  ) {
    if (state is TellUsMoreLoadSuccess) {
      final schoolName = SchoolName.dirty(event.schoolName);
      return state.copyWith(
        schoolName: schoolName,
        status: Formz.validate([
          schoolName,
          state.schoolState,
          state.schoolCity,
          state.schoolZipCode,
        ]),
      );
    } else
      return state;
  }

  TellUsMoreState _mapSchoolStateUpdatedToState(
    SchoolStateUpdated event,
    TellUsMoreState state,
  ) {
    if (state is TellUsMoreLoadSuccess) {
      final schoolState = SchoolState.dirty(event.schoolState);
      return state.copyWith(
        schoolState: schoolState,
        status: Formz.validate([
          state.schoolName,
          schoolState,
          state.schoolCity,
          state.schoolZipCode,
        ]),
      );
    } else
      return state;
  }

  TellUsMoreState _mapSchoolCityUpdatedToState(
    SchoolCityUpdated event,
    TellUsMoreState state,
  ) {
    if (state is TellUsMoreLoadSuccess) {
      final schoolCity = SchoolCity.dirty(event.schoolCity);
      return state.copyWith(
        schoolCity: schoolCity,
        status: Formz.validate([
          state.schoolName,
          state.schoolState,
          schoolCity,
          state.schoolZipCode,
        ]),
      );
    } else
      return state;
  }

  TellUsMoreState _mapSchoolZipCodeUpdatedToState(
    SchoolZipCodeUpdated event,
    TellUsMoreState state,
  ) {
    if (state is TellUsMoreLoadSuccess) {
      final schoolZipCode = SchoolZipCode.dirty(event.schoolZipCode);
      return state.copyWith(
        schoolZipCode: schoolZipCode,
        status: Formz.validate([
          state.schoolName,
          state.schoolState,
          state.schoolCity,
          state.schoolZipCode,
        ]),
      );
    } else
      return state;
  }

  Stream<TellUsMoreState> _mapTellUsMoreSubmittedToState(
    TellUsMoreSubmitted event,
    TellUsMoreState state,
  ) async* {
    if (state is TellUsMoreLoadSuccess) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          var userId = _authenticationRepository.currentUser.id;
          var authKey = _authenticationRepository.authKey;
          var vm = TeacherTellUsMoreVm();
          vm.schoolCity = state.schoolCity.value;
          vm.schoolName = state.schoolName.value;
          vm.schoolState = state.schoolState.value;
          vm.zipCode = state.schoolZipCode.value;
          await _userRepository.tellUsMore(userId, authKey, vm);
          await _authenticationRepository
              .updateUserStatus(UserStatus.teacherInfoSubmitted);
          yield state.copyWith(
            schoolName: SchoolName.pure(),
            schoolState: SchoolState.pure(),
            schoolCity: SchoolCity.pure(),
            schoolZipCode: SchoolZipCode.pure(),
            status: FormzStatus.submissionSuccess,
          );
        } catch (e) {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            error: e.toString(),
          );
        }
      }
    } else
      yield state;
  }
}
