import 'package:equatable/equatable.dart';
import 'package:swagger_api/swagger_api.dart';

enum UserStatus {
  parentSignedUp,
  parentVerifying,
  parentChildrenSubmitted,
  parentTeachersConnected,
  parentProfileCompleted,
  teacherSignedUp,
  teacherVerifying,
  teacherInfoSubmitted,
  teacherProfileCompleted,
  blocked,
  profileUpdated,
}

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.username,
    this.about,
    this.phone,
    this.email,
    this.photoImageLink,
    this.status,
    this.userStatusString,
    this.userType,
    this.meetingsCount,
    this.reportsCount,
    this.teachersCount,
    this.parentsCount,
  });

  static UserStatus statusFromString(String statusString) {
    switch (statusString) {
      case 'parentVerifying':
        return UserStatus.parentVerifying;
      case 'parentSignedUp':
        return UserStatus.parentSignedUp;
      case 'parentChildrenSubmitted':
        return UserStatus.parentChildrenSubmitted;
      case 'parentTeachersConnected':
        return UserStatus.parentTeachersConnected;
      case 'parentProfileCompleted':
        return UserStatus.parentProfileCompleted;
      case 'teacherSignedUp':
        return UserStatus.teacherSignedUp;
      case 'teacherVerifying':
        return UserStatus.teacherVerifying;
      case 'teacherInfoSubmitted':
        return UserStatus.teacherInfoSubmitted;
      case 'teacherProfileCompleted':
        return UserStatus.teacherProfileCompleted;
      case 'profileUpdated':
        return UserStatus.profileUpdated;
      case 'blocked':
        return UserStatus.blocked;
      default:
        return null;
    }
  }

  final String id;
  final String username;
  final String about;
  final String phone;
  final String email;
  final String photoImageLink;
  final UserStatus status;
  final String userStatusString;
  final int userType;
  final int meetingsCount;
  final int reportsCount;
  final int teachersCount;
  final int parentsCount;

  UserEntity copyWith({
    String id,
    bool authenticated,
    String username,
    String about,
    String phone,
    String email,
    String photoImageLink,
    UserStatus status,
    String userStatusString,
    int userType,
    int meetingsCount,
    int reportsCount,
    int teachersCount,
    int parentsCount,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      about: about ?? this.about,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      photoImageLink: photoImageLink ?? this.photoImageLink,
      status: status ?? this.status,
      userStatusString: userStatusString ?? this.userStatusString,
      userType: userType ?? this.userType,
      meetingsCount: meetingsCount ?? this.meetingsCount,
      reportsCount: reportsCount ?? this.reportsCount,
      teachersCount: teachersCount ?? this.teachersCount,
      parentsCount: parentsCount ?? this.parentsCount,
    );
  }

  static UserEntity fromApiUser(User user) {
    return UserEntity(
      id: user.id,
      username: user.username,
      phone: user.phone,
      email: user.email,
      photoImageLink: user.photoImageLink,
      status: statusFromString(user.status),
      userStatusString: user.status,
      userType: user.userType,
      meetingsCount: user.meetingsCount,
      reportsCount: user.reportsCount,
      teachersCount: user.teachersCount,
      parentsCount: user.parentsCount,
    );
  }

  @override
  List<Object> get props => [
    id,
    username,
    phone,
    email,
    photoImageLink,
    userType,
    meetingsCount,
    reportsCount,
    teachersCount,
    parentsCount,
  ];
}
