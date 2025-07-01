import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String countryCode;
  final DateTime? createdAt;
  final String passWord;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.countryCode,
    this.createdAt,
    this.passWord = 'Notes@123',
  });

  String get accountCreation =>
      DateFormat('dd MMMM yyyy').format(createdAt ?? DateTime.now());

  String get fullName => '$firstName $lastName';

  String get mobile => mobileNumber;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      countryCode: map['COUNTRY_CODE'] ?? '',
      email: map['EMAIL'] ?? '',
      firstName: map['FIRST_NAME'] ?? '',
      lastName: map['LAST_NAME'] ?? '',
      mobileNumber: map['MOBILE_NUMBER'] ?? '',
      createdAt: map['CREATED_AT'] != null
          ? (map['CREATED_AT'] as Timestamp).toDate()
          : null,
    );
  }
  factory UserModel.fromUserCredential(UserCredential map) {
    final firstName = extractNameParts(map.user?.displayName)['firstName'];
    final lastName = extractNameParts(map.user?.displayName)['lastName'];
    return UserModel(
      countryCode: '',
      email: map.user?.email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      mobileNumber: '',
    );
  }

  static Map<String, String> extractNameParts(String? displayName) {
    if (displayName == null || displayName.trim().isEmpty) {
      return {'firstName': '', 'lastName': ''};
    }

    final parts = displayName.trim().split(' ');
    final firstName = parts.isNotEmpty ? parts.first : '';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return {'firstName': firstName, 'lastName': lastName};
  }

  Map<String, dynamic> toMap() {
    return {
      'EMAIL': email,
      'FIRST_NAME': firstName,
      'LAST_NAME': lastName,
      'MOBILE_NUMBER': mobileNumber,
      'COUNTRY_CODE': countryCode,
      'CREATED_AT': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toMapUpdateData() {
    return {
      'EMAIL': email,
      'FIRST_NAME': firstName,
      'LAST_NAME': lastName,
      'MOBILE_NUMBER': mobileNumber,
      'COUNTRY_CODE': countryCode,
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    DateTime? createdAt,
    String? passWord,
    String? countryCode,
  }) {
    return UserModel(
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      createdAt: createdAt ?? this.createdAt,
      passWord: passWord ?? this.passWord,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, firstName: $firstName, lastName: $lastName, mobileNumber: $mobileNumber, createdAt: $createdAt, passWord: $passWord, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          mobileNumber == other.mobileNumber &&
          createdAt == other.createdAt &&
          passWord == other.passWord &&
          countryCode == other.countryCode;

  @override
  int get hashCode =>
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      mobileNumber.hashCode ^
      createdAt.hashCode ^
      passWord.hashCode ^
      countryCode.hashCode;
}
