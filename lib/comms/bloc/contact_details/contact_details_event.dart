part of 'contact_details_bloc.dart';

abstract class ContactDetailsEvent extends Equatable {
  const ContactDetailsEvent();

  @override
  List<Object> get props => [];
}

class ContactDetailsLoaded extends ContactDetailsEvent {
  final String contactUserId;
  final String contactUserDescription;
  final int contactUserType;
  const ContactDetailsLoaded(
      this.contactUserId, this.contactUserType, this.contactUserDescription);

  @override
  List<Object> get props =>
      [contactUserId, contactUserType, contactUserDescription];
}
