part of 'user_profile_bloc.dart';

enum UserProfileOperation {
  none,
  emailInvite,
  changeProfileDetails,
}

enum WhoCanSeeAvailability {
  justMe,
  everyone,
}

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingInProgress extends UserProfileState {}

class UserProfileLoadSuccess extends UserProfileState {
  final UserEntity userDetails;
  final bool notificationEnabled;
  final WhoCanSeeAvailability whoCanSee;
  final String inviteLink;
  final FormzStatus inviteLinkStatus;
  final String inviteLinkError;

  UserProfileLoadSuccess({
    this.userDetails,
    this.notificationEnabled = false,
    this.whoCanSee = WhoCanSeeAvailability.justMe,
    this.inviteLink,
    this.inviteLinkStatus = FormzStatus.pure,
    this.inviteLinkError,
  });

  UserProfileLoadSuccess copyWith({
    UserEntity userDetails,
    bool notificationEnabled,
    WhoCanSeeAvailability whoCanSee,
    String inviteLink,
    FormzStatus inviteLinkStatus,
    String inviteLinkError,
  }) {
    return UserProfileLoadSuccess(
      userDetails: userDetails ?? this.userDetails,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      whoCanSee: whoCanSee ?? this.whoCanSee,
      inviteLink: inviteLink ?? this.inviteLink,
      inviteLinkStatus: inviteLinkStatus ?? this.inviteLinkStatus,
      inviteLinkError: inviteLinkError ?? this.inviteLinkError,
    );
  }

  @override
  List<Object> get props => [
        userDetails,
        notificationEnabled,
        whoCanSee,
        inviteLink,
        inviteLinkStatus,
        inviteLinkError,
      ];
}

class UserProfileLoadFailure extends UserProfileState {
  final String error;
  UserProfileLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
