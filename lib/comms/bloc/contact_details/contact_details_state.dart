part of 'contact_details_bloc.dart';

abstract class ContactDetailsState extends Equatable {
  const ContactDetailsState();

  @override
  List<Object> get props => [];
}

class ContactDetailsLoadInProgress extends ContactDetailsState {}

class ContactDetailsLoadSuccess extends ContactDetailsState {
  final ContactUserDto contactUser;
  final String contactUserDescription;
  final bool isTeacher;
  final List<TeacherAvailability> teacherAvailability;

  ContactDetailsLoadSuccess({
    this.contactUser,
    this.contactUserDescription,
    this.isTeacher,
    this.teacherAvailability = const [],
  });

  @override
  List<Object> get props =>
      [contactUser, contactUserDescription, isTeacher, teacherAvailability];
}

class ContactDetailsLoadFailure extends ContactDetailsState {
  final String error;

  const ContactDetailsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
