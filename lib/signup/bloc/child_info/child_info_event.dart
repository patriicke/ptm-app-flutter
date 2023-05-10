part of 'child_info_bloc.dart';

abstract class ChildInfoEvent extends Equatable {
  const ChildInfoEvent();

  @override
  List<Object> get props => [];
}

class ChildInfoLoaded extends ChildInfoEvent {
  const ChildInfoLoaded();
}

class ChildNameUpdated extends ChildInfoEvent {
  const ChildNameUpdated(this.childName);
  final String childName;

  @override
  List<Object> get props => [childName];
}

class ChildGradeUpdated extends ChildInfoEvent {
  const ChildGradeUpdated(this.childGrade);
  final String childGrade;

  @override
  List<Object> get props => [childGrade];
}

class ChildAdded extends ChildInfoEvent {
  const ChildAdded();
}

class ChildInfoSubmitted extends ChildInfoEvent {
  const ChildInfoSubmitted();
}
