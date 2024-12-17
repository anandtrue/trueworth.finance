import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        UserCredential userCredential;
        try {
          userCredential = await _auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);
        } catch (e) {
          userCredential = await _auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
        }
        emit(AuthAuthenticated(userCredential.user!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
