part of 'meeting_request_bloc.dart';

class MeetingRequestState extends Equatable {
  const MeetingRequestState({
    this.status = FormzStatus.pure,
    this.meetingTitle = const MeetingTitle.pure(),
    this.meetingRecipient = const MeetingRecipient.pure(),
    this.meetingDate = const MeetingDate.pure(),
    this.meetingTime = const MeetingTime.pure(),
    this.searchedUsers = const [],
    this.selectedRecipientUsers = const [],
    this.searchStatus = FormzStatus.pure,
    this.error,
  });

  final FormzStatus status;
  final MeetingTitle meetingTitle;
  final MeetingRecipient meetingRecipient;
  final MeetingDate meetingDate;
  final MeetingTime meetingTime;
  final String error;

  final List<UserSearchResultDto> searchedUsers;
  final List<CreateMeetingVmUsers> selectedRecipientUsers;
  final FormzStatus searchStatus;

  MeetingRequestState copyWith({
    FormzStatus status,
    MeetingTitle meetingTitle,
    MeetingRecipient meetingParent,
    MeetingDate meetingDate,
    MeetingTime meetingTime,
    String error,
    List<UserSearchResultDto> searchedUsers,
    List<CreateMeetingVmUsers> selectedRecipientUsers,
    FormzStatus searchStatus,
  }) {
    return MeetingRequestState(
      status: status ?? this.status,
      meetingTitle: meetingTitle ?? this.meetingTitle,
      meetingRecipient: meetingParent ?? this.meetingRecipient,
      meetingDate: meetingDate ?? this.meetingDate,
      meetingTime: meetingTime ?? this.meetingTime,
      error: error ?? this.error,
      searchedUsers: searchedUsers ?? this.searchedUsers,
      selectedRecipientUsers:
          selectedRecipientUsers ?? this.selectedRecipientUsers,
      searchStatus: searchStatus ?? this.searchStatus,
    );
  }

  @override
  List<Object> get props => [
        status,
        meetingTitle,
        meetingRecipient,
        meetingDate,
        meetingTime,
        error,
        searchedUsers,
        selectedRecipientUsers,
        searchStatus,
      ];
}
