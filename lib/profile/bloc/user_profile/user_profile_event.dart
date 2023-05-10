part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileLoaded extends UserProfileEvent {
  const UserProfileLoaded();
}

class InviteLinkRequested extends UserProfileEvent {
  const InviteLinkRequested();
}

class NotificationSettingToggled extends UserProfileEvent {
  const NotificationSettingToggled();
}

class WhoCanSeeScheduleUpdated extends UserProfileEvent {
  final WhoCanSeeAvailability availability;
  const WhoCanSeeScheduleUpdated(this.availability);

  @override
  List<Object> get props => [availability];
}

class LogoutRequested extends UserProfileEvent {
  const LogoutRequested();
}
