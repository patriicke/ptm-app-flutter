part of 'contact_selection_bloc.dart';

abstract class ContactSelectionState extends Equatable {
  const ContactSelectionState();

  @override
  List<Object> get props => [];
}

class ContactSelectionLoadInProgress extends ContactSelectionState {}

class ContactSelectionLoadSuccess extends ContactSelectionState {
  final List<SearchContactDto> contacts;
  ContactSelectionLoadSuccess(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ContactSelectionLoadFailure extends ContactSelectionState {
  final String error;
  ContactSelectionLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
