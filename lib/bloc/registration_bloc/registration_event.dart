// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

class RegistrationEvent {}

class RegistrationEventStart extends RegistrationEvent{
    String userId;
    String mobileNumber;
    String firstName;
    String lastName;
    String password;
    bool active;
  RegistrationEventStart({
    required this.userId,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.active,
  });

}
