import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveUserEvent extends UserEvent {
  final String name;
  final String email;
  final String panCard;

  SaveUserEvent({required this.name, required this.email, required this.panCard});

  @override
  List<Object?> get props => [name, email, panCard];
}

class LoadUserEvent extends UserEvent {}
