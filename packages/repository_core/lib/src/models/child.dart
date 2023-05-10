import 'package:uuid/uuid.dart';

class Child {
  Child({
    String id,
    this.name,
    this.grade,
  }) : this.id = id ?? Uuid().v4();

  final String id;
  final String name;
  final String grade;

  Child copyWith({
    String id,
    String name,
    String grade,
  }) {
    return Child(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        grade,
      ];

  @override
  String toString() {
    return 'Child {id: $id, name: $name, grade: $grade}';
  }
}
