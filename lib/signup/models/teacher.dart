import 'package:uuid/uuid.dart';

class Teacher {
  Teacher({
    String id,
    this.name,
    this.subject,
  }) : this.id = id ?? Uuid().v4();

  final String id;
  final String name;
  final String subject;

  Teacher copyWith({
    String id,
    String name,
    String grade,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: grade ?? this.subject,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        subject,
      ];

  @override
  String toString() {
    return 'Teacher {id: $id, name: $name, subject: $subject}';
  }
}
