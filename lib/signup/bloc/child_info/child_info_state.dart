part of 'child_info_bloc.dart';

abstract class ChildInfoState extends Equatable {
  const ChildInfoState();

  @override
  List<Object> get props => [];
}

class ChildInfoLoadInProgress extends ChildInfoState {}

class ChildInfoLoadSuccess extends ChildInfoState {
  const ChildInfoLoadSuccess({
    this.status = FormzStatus.pure,
    this.children = const [],
    this.childName = const ChildName.pure(),
    this.childGrade = const ChildGrade.pure(),
    this.grades = const [],
  });

  final FormzStatus status;
  final List<ParentChild> children;
  final ChildName childName;
  final ChildGrade childGrade;
  final List<GradeDto> grades;

  ChildInfoLoadSuccess copyWith({
    FormzStatus status,
    List<ParentChild> children,
    ChildName childName,
    ChildGrade childGrade,
    List<GradeDto> grades,
  }) {
    return ChildInfoLoadSuccess(
      status: status ?? this.status,
      children: children ?? this.children,
      childName: childName ?? this.childName,
      childGrade: childGrade ?? this.childGrade,
      grades: grades ?? this.grades,
    );
  }

  @override
  List<Object> get props => [
        status,
        children,
        childName,
        childGrade,
        grades,
      ];
}

class ChildInfoLoadFailure extends ChildInfoState {
  final String error;
  ChildInfoLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
