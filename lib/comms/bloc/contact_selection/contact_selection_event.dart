part of 'contact_selection_bloc.dart';

abstract class ContactSelectionEvent extends Equatable {
  const ContactSelectionEvent();

  @override
  List<Object> get props => [];
}

class ContactSelectionLoaded extends ContactSelectionEvent {}
