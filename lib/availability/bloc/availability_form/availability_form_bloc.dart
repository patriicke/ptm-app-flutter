import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/availability/model/availability_date.dart';
import 'package:meetings/availability/model/availability_time.dart';
import 'package:meetings/availability/model/repeat_end_date.dart';
import 'package:meetings/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'availability_form_event.dart';
part 'availability_form_state.dart';

class AvailabilityFormBloc
    extends Bloc<AvailabilityFormEvent, AvailabilityFormState> {
  AvailabilityFormBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(AvailabilityFormState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<AvailabilityFormState> mapEventToState(
    AvailabilityFormEvent event,
  ) async* {
    if (event is DateUpdated) {
      yield _mapDateUpdatedToState(event, state);
    } else if (event is StartTimeUpdated) {
      yield _mapStartTimeUpdatedToState(event, state);
    } else if (event is EndTimeUpdated) {
      yield _mapEndTimeUpdatedToState(event, state);
    } else if (event is AvailabilityTypeUpdated) {
      yield _mapAvailabilityTypeUpdatedToState(event, state);
    } else if (event is RepeatToggled) {
      yield _mapRepeatToggledToState(event, state);
    } else if (event is RepeatsEveryUpdated) {
      yield _mapRepeatsEveryUpdatedToState(event, state);
    } else if (event is RepeatEndDateUpdated) {
      yield _mapRepeatEndDateUpdatedToState(event, state);
    } else if (event is WhoCanSeeUpdated) {
      yield _mapWhoCanSeeUpdatedToState(event, state);
    } else if (event is AvailabilityFormSubmitted) {
      yield* _mapAvailabilityFormSubmittedToState(event, state);
    }
  }

  AvailabilityFormState _mapDateUpdatedToState(
      DateUpdated event, AvailabilityFormState state) {
    final availabilityDate = AvailabilityDate.dirty(event.date);
    return state.copyWith(
      date: availabilityDate,
      status: Formz.validate([
        availabilityDate,
        state.startTime,
        state.endTime,
        state.repeatEndDate,
      ]),
    );
  }

  AvailabilityFormState _mapStartTimeUpdatedToState(
      StartTimeUpdated event, AvailabilityFormState state) {
    final startTime = AvailabilityTime.dirty(event.startTime);
    return state.copyWith(
      startTime: startTime,
      status: Formz.validate([
        state.date,
        startTime,
        state.endTime,
        state.repeatEndDate,
      ]),
    );
  }

  AvailabilityFormState _mapEndTimeUpdatedToState(
      EndTimeUpdated event, AvailabilityFormState state) {
    final endTime = AvailabilityTime.dirty(event.endTime);
    return state.copyWith(
      endTime: endTime,
      status: Formz.validate([
        state.date,
        state.startTime,
        endTime,
        state.repeatEndDate,
      ]),
    );
  }

  AvailabilityFormState _mapAvailabilityTypeUpdatedToState(
      AvailabilityTypeUpdated event, AvailabilityFormState state) {
    return state.copyWith(availabilityType: event.availabilityType);
  }

  AvailabilityFormState _mapRepeatToggledToState(
      RepeatToggled event, AvailabilityFormState state) {
    return state.copyWith(repeats: !state.repeats);
  }

  AvailabilityFormState _mapRepeatsEveryUpdatedToState(
      RepeatsEveryUpdated event, AvailabilityFormState state) {
    return state.copyWith(repeatsEvery: event.repeatsEvery);
  }

  AvailabilityFormState _mapRepeatEndDateUpdatedToState(
      RepeatEndDateUpdated event, AvailabilityFormState state) {
    final repeatEndDate = RepeatEndDate.dirty(event.repeatEndDate);
    return state.copyWith(
      repeatEndDate: repeatEndDate,
      status: Formz.validate([
        state.date,
        state.startTime,
        state.endTime,
        repeatEndDate,
      ]),
    );
  }

  AvailabilityFormState _mapWhoCanSeeUpdatedToState(
      WhoCanSeeUpdated event, AvailabilityFormState state) {
    return state.copyWith(whoCanSee: event.whoCanSee);
  }

  Stream<AvailabilityFormState> _mapAvailabilityFormSubmittedToState(
      AvailabilityFormSubmitted event, AvailabilityFormState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        var teacherApi = TeacherApi();
        var authKey = _authenticationRepository.authKey;
        var userId = _authenticationRepository.currentUser.id;
        var vm = SetTeacherAvailabilityVm()
          ..availabilityDate = state.date.value
          ..availabilityStartTime = state.startTime.value
          ..availabilityEndTime = state.endTime.value
          ..availabilityType = state.availabilityType
              .toString()
              .substring(state.availabilityType.toString().indexOf('.') + 1)
          ..repeat = state.repeats
          ..repeatEvery = state.repeatsEvery
              .toString()
              .substring(state.repeatsEvery.toString().indexOf('.') + 1)
          ..repeatEndDate = state.repeatEndDate.value
          ..whoCanSee = state.whoCanSee
              .toString()
              .substring(state.whoCanSee.toString().indexOf('.') + 1);
        var response =
            await teacherApi.setTeacherAvailability(authKey, userId, vm);

        if (response.apiResponseMessage.code != 200) {
          log('Exception when calling TeacherApi->setTeacherAvailability. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          throw Exception(
              'Exception when calling TeacherApi->setTeacherAvailability. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
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
