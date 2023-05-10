import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'notifications_list_event.dart';
part 'notifications_list_state.dart';

class NotificationsListBloc
    extends Bloc<NotificationsListEvent, NotificationsListState> {
  NotificationsListBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(NotificationsListLoadInProgress());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<NotificationsListState> mapEventToState(
    NotificationsListEvent event,
  ) async* {
    if (event is NotificationsListLoaded) {
      yield* _mapNotificationsListLoadedToState(event);
    }
  }

  Stream<NotificationsListState> _mapNotificationsListLoadedToState(
    NotificationsListLoaded event,
  ) async* {
    yield NotificationsListLoadInProgress();
    try {
      var notificationsApi = NotificationApi();
      var notificationFilter = event.filterType == null
          ? 'all'
          : event.filterType
              .toString()
              .substring(event.filterType.toString().indexOf('.') + 1);
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var notifications = await notificationsApi.getUserNotifications(
          notificationFilter, authKey, userId);

      if (notifications.apiResponseMessage.code != 200) {
        log('Exception when calling NotificationApi->getUserNotifications. code: ${notifications.apiResponseMessage.code}, message: ${notifications.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling NotificationApi->getUserNotifications. code: ${notifications.apiResponseMessage.code}, message: ${notifications.apiResponseMessage.message}\n');
      }

      var meetingsApi = MeetingApi();
      var meetingRequests =
          await meetingsApi.getMeetingRequests(authKey, userId);

      if (meetingRequests.apiResponseMessage.code != 200) {
        log('Exception when calling MeetingApi->getMeetingRequests. code: ${meetingRequests.apiResponseMessage.code}, message: ${meetingRequests.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling MeetingApi->getMeetingRequests. code: ${meetingRequests.apiResponseMessage.code}, message: ${meetingRequests.apiResponseMessage.message}\n');
      }

      var teacherApi = TeacherApi();
      var connectionRequests =
          await teacherApi.getTeacherConnectionRequests(authKey, userId);

      if (connectionRequests.apiResponseMessage.code != 200) {
        log('Exception when calling TeacherApi->getTeacherConnectionRequests. code: ${connectionRequests.apiResponseMessage.code}, message: ${connectionRequests.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TeacherApi->getTeacherConnectionRequests. code: ${connectionRequests.apiResponseMessage.code}, message: ${connectionRequests.apiResponseMessage.message}\n');
      }

      yield NotificationsListLoadSuccess(
          notifications.data, meetingRequests.data, connectionRequests.data);
    } catch (e) {
      yield NotificationsListLoadFailure(e.toString());
    }
  }
}
